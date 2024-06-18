resource "aws_iot_topic_rule" "this" {
  name        = var.rule_name
  description = var.description
  sql         = var.sql
  sql_version = var.sql_version
  enabled = var.enabled
  dynamodb {
    table_name       = var.dynamodb_table_name
    role_arn         = var.dynamodb_role_arn
    hash_key_field   = var.dynamodb_hash_key_field
    hash_key_value   = var.dynamodb_hash_key_value
    range_key_field  = var.dynamodb_range_key_field
    range_key_value  = var.dynamodb_range_key_value
  }
  s3 {
    role_arn         = var.s3_role_arn
    bucket_name      = var.s3_bucket_name
    key              = var.s3_key
  }
  tags = var.tags
}
