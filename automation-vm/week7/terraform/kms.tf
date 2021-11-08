resource "aws_kms_key" "week7-key" {
  description             = "KMS Week 7"
}

resource "aws_kms_alias" "week7-kms" {
  name          = "alias/week7-kms"
  target_key_id = aws_kms_key.week7-key.key_id
}
