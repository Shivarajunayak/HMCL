
################################################################################
# Security Groups
################################################################################


module "security_groups" {

  for_each = var.security_groups

  source = "./aws-sg"

  name          = try(each.value.name, null)
  description   = try(each.value.description, null)
  vpc_id        = each.value.vpc_id
  ingress_rules = try(each.value.ingress_rules, {})
  egress_rules  = try(each.value.egress_rules, {})
  tags          = try(each.value.tags, {})
}
