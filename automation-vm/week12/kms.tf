resource "aws_kms_key" "week12-key" {
  description             = "KMS Week 7"
}

resource "aws_kms_alias" "week12-kms" {
  name          = "alias/week12-kms"
  target_key_id = aws_kms_key.week12-key.key_id
}
