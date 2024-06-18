variable "role_name" {
  description = "Name of the IAM role for IoT topic rule"
  type        = string
}
variable "assume_role_policy" {
  description = "IAM role assume role policy"
  type        = string
}
variable "security_group_id" {
  description = "Name of the security group for IoT topic rule"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the VPC configuration"
  type        = list(string)
}
variable "vpc_id" {
  description = "ID of the VPC where resources will be deployed"
  type        = string
}
variable "iot_destinations_custom_policy_json" {
  description = "IAM policy JSON for IoT destinations"
  type        = string
}

variable "iam_policy_name" {
  description = "Custom IAM Policy name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = any
  default     = {}
}