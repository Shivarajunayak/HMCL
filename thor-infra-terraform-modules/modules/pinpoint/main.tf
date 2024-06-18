module "pinpoint_notifications" {
  source   = "./aws-pinpoint"
  for_each = var.parameters

  name              = try(each.value.name, each.key) # cannot be null
  email             = try(each.value.email, null)
  sms               = try(each.value.sms, null)
  baidu             = try(each.value.baidu, null)
  apns              = try(each.value.apns, null)
  apns_sandbox      = try(each.value.apns_sandbox, null)
  apns_voip         = try(each.value.apns_voip, null)
  apns_voip_sandbox = try(each.value.apns_voip_sandbox, null)


}
