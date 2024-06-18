variable "bucket" {
  description = "S3 bucket name"
  type        = string
}
variable "s3_object_key" {
  description = "Key of the object in S3"
  type        = string
}

variable "flink_role_arn" {
  description = "Flink Role ARN"
  type        = string
}

variable "cloudwatch_log_group" {
  description = "Name of CloudWatch Log Group"
  type        = string
}
variable "cloudwatch_log_stream" {
  description = "Name of CloudWatch Log Stream"
  type        = string
}
variable "application_name" {
  description = "Name of the Kinesis Analytics application"
  type        = string
}
variable "runtime_environment" {
  description = "Runtime environment for the Kinesis Analytics application"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the VPC configuration"
  type        = list(string)
}
variable "security_group_id" {
  description = "Security group ID for the VPC configuration"
  type        = string
}
variable "tags" {
  description = "Tags for AWS resources"
  type        = any
  default = {}
}
variable "flink_application_properties" {
  description = "Properties for the Flink application"
  type        = list(object({
    property_group_id = string
    property_map      = map(string)
  }))
}
variable "flink_application_configuration" {
  description = "List of Flink application configurations"
  type        = list(object({
    checkpoint_configuration_type   = string
    monitoring_configuration_type   = string
    log_level                       = string
    metrics_level                   = string
    auto_scaling_enabled            = bool
    parallelism_configuration_type  = string
    parallelism                     = number
    parallelism_per_kpu             = number
  }))
}
