variable "role_name" {
  type        = string
  description = "roles name"
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

variable "trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}
variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = false
}

variable "create_instance_profile" {
  description = "Whether to create an instance profile"
  type        = bool
  default     = false
}
