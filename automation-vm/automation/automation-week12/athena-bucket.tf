resource "aws_s3_bucket" "ece592-athena-cache-suikerk" {
  bucket = "ece592-athena-cache-suikerk"
  acl    = "private"

  tags = {
    Name        = "ece592-athena-cache-suikerk"
  }
}
