variable "rule_name" {
  description = "The name of the IoT topic rule."
  type        = string
}
variable "description" {
  description = "The description of the IoT topic rule."
  type        = string
  default     = null
}
variable "sql" {
  description = "The SQL statement used to query the topic."
  type        = string
}
variable "sql_version" {
  description = "The version of the SQL rules engine to use."
  type        = string
  default     = "2015-10-08"
}
variable "enabled" {
  description = "Specifies whether the rule is enabled."
  type        = bool
  default     = true
}
variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table."
  type        = string
  default     = null
}
variable "dynamodb_role_arn" {
  description = "The ARN of the IAM role that grants access to the DynamoDB table."
  type        = string
  default     = null
}
variable "dynamodb_hash_key_field" {
  description = "The name of the hash key field in the DynamoDB table."
  type        = string
  default     = null
}
variable "dynamodb_hash_key_value" {
  description = "The value of the hash key."
  type        = string
  default     = null
}
variable "dynamodb_range_key_field" {
  description = "The name of the range key field in the DynamoDB table."
  type        = string
  default     = null
}
variable "dynamodb_range_key_value" {
  description = "The value of the range key."
  type        = string
  default     = null
}
variable "s3_role_arn" {
  description = "The ARN of the IAM role that grants access to the S3 bucket."
  type        = string
  default     = null
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  default     = null
}
variable "s3_key" {
  description = "The key of the object in the S3 bucket."
  type        = string
  default     = null
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

