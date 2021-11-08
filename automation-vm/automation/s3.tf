resource "aws_s3_bucket" "automation-s3" {
  bucket = "ece592-automation-suikerk"
  acl    = "private"

  tags = {
    Name = "ece592-automation-suikerk"
  }

  # Keep old versions of the state file.
  versioning {
    enabled = true
  }

  # Transition old versions to cheaper storage after 30 days.
  lifecycle_rule {
    enabled = true
    tags    = {}

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  # Encryption at rest using default AWS keys!
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "ece592-cloudtrail-suikerk" {
  bucket = "ece592-cloudtrail-suikerk"
  acl    = "private"

  tags = {
    Name = "ece592-cloudtrail-suikerk"
  }

  # Keep old versions of the state file.
  versioning {
    enabled = true
  }

  # Transition old versions to cheaper storage after 30 days.
  lifecycle_rule {
    enabled = true
    tags    = {}

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  # Encryption at rest using default AWS keys!
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::ece592-cloudtrail-suikerk"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::ece592-cloudtrail-suikerk/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
