resource "aws_s3_bucket" "week11-s3" {
  bucket = "ece592-week11-suikerk"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.week11-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


resource "aws_lambda_permission" "week11-bucket-lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.week11-s3.arn
}


resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.week11-s3.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

#  depends_on = [aws_lambda_permission.week11-bucket-lambda]
}


#resource "aws_s3_bucket_public_access_block" "bucket-block" {
#  bucket = aws_s3_bucket.week11-bucket.id
#
#  block_public_acls   = true
#  block_public_policy = true
#}
