module "iam_role" {

  for_each                = { for i, v in var.iam_configs : i => v }
  source                  = "./aws-iam-invoked"
  create_role             = each.value.create_role
  create_instance_profile = each.value.create_instance_profile
  role_name               = each.value.role_name
  policy                  = each.value.policy
  environment             = var.environment
  role_policy_path        = var.role_policy_path
  trusted_role_arns       = each.value.trusted_role_arns
  trusted_role_services   = each.value.trusted_role_services

}
