module "opensearch" {
  source = "./aws-opensearch"

  advanced_options          = try(var.advanced_options, {})
  advanced_security_options = try(var.advanced_security_options, {})
  auto_tune_options         = try(var.auto_tune_options, {})
  cluster_config            = try(var.cluster_config, {})
  domain_endpoint_options   = try(var.domain_endpoint_options, {})
  domain_name               = try(var.domain_name, "my-domain")
  ebs_options               = try(var.ebs_options, {})
  encrypt_at_rest           = try(var.encrypt_at_rest, {})
  engine_version            = try(var.engine_version, null)
  log_publishing_options    = try(var.log_publishing_options, [])
  node_to_node_encryption   = try(var.node_to_node_encryption, {})
  software_update_options   = try(var.software_update_options, {})
  vpc_options               = try(var.vpc_options, {})
  tags                      = try(var.tags, {})
}
