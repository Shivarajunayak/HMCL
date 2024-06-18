
variable "iam_role_name" {
  description = "Name of the IAM role for Glue job"
  type        = string
  default     = "my-glue-role"
}
variable "iam_policy_name" {
  description = "Custom IAM Policy name"
  type        = string
  default     = ""
}

variable "custom_policy_json" {
  description = "glue role custom policy"
  type        = string
}