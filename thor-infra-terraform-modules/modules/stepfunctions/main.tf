module "step_function" {
  source = "./aws-step-functions"

  name                 = var.name
  type                 = var.type
  tags                 = var.tags
  definition           = var.definition
  service_integrations = var.service_integrations
}
