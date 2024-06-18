variable "create" {
  description = "Boolean flag to control the creation of resources"
  type        = bool
  default     = true
}
variable "log_groups" {
  description = "List of log group configurations"
  type = list(object({
    name              = string
    retention_in_days = number
    kms_key_id        = string
    log_group_class   = string
    skip_destroy      = bool
    tags              = map(string)
  }))
  default = [
    {
      name              = "log-group-1"
      retention_in_days = 7
      kms_key_id        = ""
      log_group_class   = "STANDARD"
      skip_destroy      = true
      tags              = { "Environment" = "Production" }
    },
    {
      name              = "log-group-2"
      retention_in_days = 14
      kms_key_id        = ""
      log_group_class   = "STANDARD"
      skip_destroy      = false
      tags              = { "Environment" = "Staging" }
    }
  ]
}
variable "default_retention_in_days" {
  description = "Default retention period for log groups"
  type        = number
  default     = 30
}
variable "default_kms_key_id" {
  description = "Default KMS key ID"
  type        = string
  default     = ""
}
variable "default_log_group_class" {
  description = "Default log group class"
  type        = string
  default     = "STANDARD"
}
variable "default_skip_destroy" {
  description = "Default value for skip destroy"
  type        = bool
  default     = false
}
