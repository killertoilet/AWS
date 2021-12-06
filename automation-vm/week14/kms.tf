resource "aws_kms_key" "week14-key" {
  description             = "KMS Week 7"
}

resource "aws_kms_alias" "week14-kms" {
  name          = "alias/week14-kms"
  target_key_id = aws_kms_key.week14-key.key_id
}
