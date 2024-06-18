variable "athena_db_name" {
  description = "The name of the Athena database"
  type        = string
  default     = null
}
 
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = null
}

variable "bucket" {
  description = "The name of the S3 bucket"
  type        = string
  default     = null
}
 
variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for encryption"
  type        = string
  default     = null
}
 
variable "force_destroy" {
  description = "Whether to force destroy the Athena database"
  type        = bool
  default     = null
}
 
variable "workgroup_name" {
  description = "The name of the Athena workgroup"
  type        = string
  default     = null
}
 
variable "enforce_workgroup_config" {
  description = "Whether to enforce the workgroup configuration"
  type        = bool
  default     = null
}
 
variable "publish_cloudwatch_metrics" {
  description = "Whether to publish CloudWatch metrics"
  type        = bool
  default     = null
}
 
variable "output_location" {
  description = "The S3 location for query results"
  type        = string
  default     = null
}
 
variable "table_name" {
  description = "The name of the Glue Catalog table"
  type        = string
  default     = null
}
 
variable "table_type" {
  description = "The type of the Glue Catalog table"
  type        = string
  default     = null
}
 
variable "skip_header_line_count" {
  description = "The number of header lines to skip"
  type        = string
  default     = null
}
 
variable "input_format" {
  description = "The input format for the table"
  type        = string
  default     = null
}
 
variable "output_format" {
  description = "The output format for the table"
  type        = string
  default     = null
}
 
variable "serde_name" {
  description = "The name of the SerDe"
  type        = string
  default     = null
}
 
variable "serialization_library" {
  description = "The serialization library for the SerDe"
  type        = string
  default     = null
}
 
variable "serialization_format" {
  description = "The serialization format"
  type        = string
  default     = null
}
 
variable "columns" {
  description = "List of columns for the Glue Catalog table"
  type        = list(object({
    name = string
    type = string
  }))
  default     = null
}
 
variable "named_query_name" {
  description = "The name of the Athena named query"
  type        = string
  default     = null
}
 
variable "query" {
  description = "The SQL query for the Athena named query"
  type        = string
  default     = null
}