resource "aws_iot_account_audit_configuration" "iot_audit_config" {
  account_id = var.account_id
  role_arn   = var.iot_role_arn
  audit_check_configurations {
    authenticated_cognito_role_overly_permissive_check {
      enabled = var.audit_checks.authenticated_cognito_role_overly_permissive_check.enabled
    }
    ca_certificate_expiring_check {
      enabled = var.audit_checks.ca_certificate_expiring_check.enabled
    }
    ca_certificate_key_quality_check {
      enabled = var.audit_checks.ca_certificate_key_quality_check.enabled
    }
    conflicting_client_ids_check {
      enabled = var.audit_checks.conflicting_client_ids_check.enabled
    }
    device_certificate_expiring_check {
      enabled = var.audit_checks.device_certificate_expiring_check.enabled
    }
    device_certificate_key_quality_check {
      enabled = var.audit_checks.device_certificate_key_quality_check.enabled
    }
    device_certificate_shared_check {
      enabled = var.audit_checks.device_certificate_shared_check.enabled
    }
    intermediate_ca_revoked_for_active_device_certificates_check {
      enabled = var.audit_checks.intermediate_ca_revoked_for_active_device_certificates_check.enabled
    }
    io_t_policy_potential_mis_configuration_check {
      enabled = var.audit_checks.io_t_policy_potential_mis_configuration_check.enabled
    }
    iot_policy_overly_permissive_check {
      enabled = var.audit_checks.iot_policy_overly_permissive_check.enabled
    }
    iot_role_alias_allows_access_to_unused_services_check {
      enabled = var.audit_checks.iot_role_alias_allows_access_to_unused_services_check.enabled
    }
    iot_role_alias_overly_permissive_check {
      enabled = var.audit_checks.iot_role_alias_overly_permissive_check.enabled
    }
    logging_disabled_check {
      enabled = var.audit_checks.logging_disabled_check.enabled
    }
    revoked_ca_certificate_still_active_check {
      enabled = var.audit_checks.revoked_ca_certificate_still_active_check.enabled
    }
    revoked_device_certificate_still_active_check {
      enabled = var.audit_checks.revoked_device_certificate_still_active_check.enabled
    }
    unauthenticated_cognito_role_overly_permissive_check {
      enabled = var.audit_checks.unauthenticated_cognito_role_overly_permissive_check.enabled
    }
  }
  audit_notification_target_configurations {
    sns {
      enabled    = true
      role_arn   = var.sns_role_arn
      target_arn = var.sns_target_arn
    }
  }
}