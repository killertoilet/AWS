resource "aws_kms_key" "week11-key" {
  description             = "KMS Week 7"
}

resource "aws_kms_alias" "week11-kms" {
  name          = "alias/week11-kms"
  target_key_id = aws_kms_key.week11-key.key_id
}
