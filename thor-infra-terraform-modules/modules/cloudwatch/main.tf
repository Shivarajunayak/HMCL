module "cloudwatch" {
  source            = "./aws-cloudwatch/modules/log-group"
  for_each          = { for idx, log_group in var.log_groups : idx => log_group }
  create            = var.create
  name              = each.value.name
  retention_in_days = each.value.retention_in_days != null ? each.value.retention_in_days : var.default_retention_in_days
  kms_key_id        = each.value.kms_key_id != "" ? each.value.kms_key_id : var.default_kms_key_id
  log_group_class   = each.value.log_group_class != "" ? each.value.log_group_class : var.default_log_group_class
  skip_destroy      = each.value.skip_destroy != null ? each.value.skip_destroy : var.default_skip_destroy
  tags              = each.value.tags
}
