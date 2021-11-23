resource "aws_s3_bucket" "ece592-flowlogs-suikerk" {
  bucket        = "ece592-flowlogs-suikerk"
  force_destroy = true
  lifecycle_rule {
    prefix  = "config/"
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 180
      storage_class = "GLACIER"
    }

   
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSFlowLogsAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::ece592-flowlogs-suikerk"
        },
        {
            "Sid": "AWSFlowLogsWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::ece592-flowlogs-suikerk/*",
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

resource "aws_flow_log" "flowlogs" {
	log_destination = aws_s3_bucket.ece592-flowlogs-suikerk.arn
	log_destination_type = "s3"
	traffic_type = "ALL"
	vpc_id = aws_vpc.automation-vpc.id

}
