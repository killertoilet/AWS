resource "aws_kms_key" "week6-key" {
  description             = "KMS Week 6"
}

resource "aws_kms_alias" "week6-key" {
  name          = "alias/week6-key"
  target_key_id = aws_kms_key.week6-key.key_id
}
