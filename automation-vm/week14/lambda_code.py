#
# ece592 - week 13
#

import json
import boto3
import pymysql

from random import randint

from peewee import (
    AutoField,
    CharField,
    DatabaseProxy,
    DateField,
    DateTimeField,
    ForeignKeyField,
    Model,
    MySQLDatabase,
    SqliteDatabase,
)


# Create a proxy for the DB.  This is because we don't know what kind of DB
# we are connecting to until runtime.
database_proxy = DatabaseProxy()

db = None

class BaseModel(Model):
    class Meta:
        database = database_proxy


class UrlMapping(BaseModel):

    url = CharField(primary_key=True, max_length=1024)
    hash = CharField(unique=True, max_length=20)

    FIELDS = [url, hash]


class Database:

    TABLES = [
        UrlMapping,
    ]

    def __init__(self, db_type, secret=None):

        global db

        if db_type == 'sqlite':
            self.db = SqliteDatabase('ece592.db')
        elif db_type == 'aws':
            # If the "urls" DB doesn't exist in the Aurora DB we need to create it.
            Database._create(secret, 'urls')

            self.db = MySQLDatabase(
                'urls',
                host=secret['db'],
                port=3306,
                user=secret['username'],
                passwd=secret['password'])

        self.db.connect()
        database_proxy.initialize(self.db)
        self._create_tables()
        db = self.db

    def _create_tables(self):
        self.db.create_tables(self.TABLES)

    @classmethod
    def _create(klass, secret, database_name):
        # PeeWee doesn't have a way to create an actual MySQL database, so we have
        # to rely on another library for that.
        conn = pymysql.connect(host=secret['db'], user=secret['username'], password=secret['password'])
        try:
            conn.cursor().execute(f'CREATE DATABASE {database_name}')
        except Exception:
            # Database probably already exists.
            pass
        conn.close()

    def close(self):
        self.db.close()

    def delete(self):
        self.db.drop_tables(self.TABLES)

    def accounts(self):
        return Account.select().dicts()


def get_secret(secret_name):
    sm = boto3.client('secretsmanager')
    res = sm.get_secret_value(SecretId=secret_name)

    secret_key = res['SecretString']
    return json.loads(secret_key)


def handle_http_get(event):
    hash = event['requestContext']['http']['path'].split('/')[-1]
    rec = UrlMapping.select().where(UrlMapping.hash==hash)
    if len(rec):
        return 301, rec[0].url
    else:
        return 404, 'Id Not Found'


def handle_http_post(event):
    body = json.loads(event['body'])
    url = body['url']

    # Fake hash!
    hash = randint(10000, 99999)

    # Kill any existing mapping.
    UrlMapping.delete().where(UrlMapping.url==url).execute()

    # Store this mapping.
    UrlMapping.create(url=url, hash=hash)

    # Return the "hash".
    return 200, {'id': hash}


def lambda_handler(event, context):
    print(json.dumps(event))
    print(context)

    # Really only need to do this one time...
    secret = get_secret('week13-secret')
    db = Database('aws', secret)

    # Process the request.
    if event['requestContext']['http']['method'] == 'POST':
        status_code, body = handle_http_post(event)
    else:
        status_code, body = handle_http_get(event)

    if status_code == 301:
        # Redirect
        response = {}
        response["statusCode"] = status_code
        response["headers"] = {'Location': body}
        data = {}
        response["body"]=json.dumps(data)
        return response
    else:
        return {
            'statusCode': status_code,
            'body': json.dumps(body)
        }


if __name__ == '__main__':
    secret = get_secret('week13-secret')
    db = Database('aws', secret)
