variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2"
}
variable "account_id" {
  description = "Your 12-digit AWS account ID"
  type        = string
}
variable "iot_role_arn" {
  description = "The ARN of the IAM role that grants AWS IoT permission to perform audits"
  type        = string
}
variable "sns_role_arn" {
  description = "The ARN of the IAM role that grants permission to send notifications to the SNS topic"
  type        = string
}
variable "sns_target_arn" {
  description = "The ARN of the SNS topic to which notifications are sent"
  type        = string
}
variable "audit_checks" {
  description = "Configuration for audit checks"
  type = map(object({
    enabled = bool
  }))
  default = {
    authenticated_cognito_role_overly_permissive_check = { enabled = true }
    ca_certificate_expiring_check                      = { enabled = true }
    ca_certificate_key_quality_check                   = { enabled = true }
    conflicting_client_ids_check                       = { enabled = true }
    device_certificate_expiring_check                  = { enabled = true }
    device_certificate_key_quality_check               = { enabled = true }
    device_certificate_shared_check                    = { enabled = true }
    intermediate_ca_revoked_for_active_device_certificates_check = { enabled = true }
    io_t_policy_potential_mis_configuration_check      = { enabled = true }
    iot_policy_overly_permissive_check                 = { enabled = true }
    iot_role_alias_allows_access_to_unused_services_check = { enabled = true }
    iot_role_alias_overly_permissive_check             = { enabled = true }
    logging_disabled_check                             = { enabled = true }
    revoked_ca_certificate_still_active_check          = { enabled = true }
    revoked_device_certificate_still_active_check      = { enabled = true }
    unauthenticated_cognito_role_overly_permissive_check = { enabled = true }
  }
}