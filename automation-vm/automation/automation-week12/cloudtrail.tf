resource "aws_cloudtrail" "ece592-cloudtrail" {
  name                          = "ece592-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.ece592-cloudtrail-suikerk.id
  include_global_service_events = true
  is_multi_region_trail         = true
  s3_key_prefix                 = "prefix"
}
