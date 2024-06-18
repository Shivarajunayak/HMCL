module "parameters" {
  source = "./aws-ssm-parameter-store"

  for_each = var.parameters

  create               = try(each.value.create, false)
  ignore_value_changes = try(each.value.ignore_value_changes, false)
  tags                 = try(each.value.tags, {})
  name                 = try(each.value.name, each.key)
  value                = try(each.value.value, null)
  values               = try(each.value.values, [])
  type                 = try(each.value.type, null)
  secure_type          = try(each.value.secure_type, false)
  description          = try(each.value.description, null)
  tier                 = try(each.value.tier, null)
  key_id               = try(each.value.key_id, null)
  allowed_pattern      = try(each.value.allowed_pattern, null)
  data_type            = try(each.value.data_type, null)
}
