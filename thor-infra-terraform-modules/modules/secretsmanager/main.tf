
module "secrets_manager" {
  source                   = "./aws-secrets-manager"
  secrets                  = var.secrets
  unmanaged                = true
  rotation_enabled         = var.rotation_enabled
  automatically_after_days = var.automatically_after_days
}
