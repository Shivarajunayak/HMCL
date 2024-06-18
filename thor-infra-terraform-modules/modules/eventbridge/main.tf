module "eventbridge" {
  source = "./aws-eventbridge"

  bus_name       = var.bus_name
  create_targets = var.create_targets
  rules          = var.rules
  targets        = var.targets
}
