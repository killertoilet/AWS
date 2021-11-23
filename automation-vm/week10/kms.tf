resource "aws_kms_key" "week10-key" {
  description             = "KMS Week 7"
}

resource "aws_kms_alias" "week10-kms" {
  name          = "alias/week10-kms"
  target_key_id = aws_kms_key.week10-key.key_id
}
