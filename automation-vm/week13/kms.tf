resource "aws_kms_key" "week13-key" {
  description             = "KMS Week 7"
}

resource "aws_kms_alias" "week13-kms" {
  name          = "alias/week13-kms"
  target_key_id = aws_kms_key.week13-key.key_id
}
