# variable "role_name" {
#   type        = string
#   description = "roles name"
# }

variable "iam_configs" {
  description = "List of iam roles to be created"
  type        = any
  default     = []
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "policy" {
  type    = any
  default = {}
}

variable "role_policy_path" {
  type    = string
  default = "/"
}
