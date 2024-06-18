module "msk_kafka_cluster" {
  source = "./aws-msk"

  create                 = try(var.create, false)
  name                   = var.name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes
  enhanced_monitoring    = var.enhanced_monitoring

  broker_node_client_subnets  = try(var.broker_node_client_subnets, [])
  broker_node_storage_info    = var.broker_node_storage_info
  broker_node_instance_type   = var.broker_node_instance_type
  broker_node_security_groups = try(var.broker_node_security_groups, [])

  encryption_in_transit_client_broker = try(var.encryption_in_transit_client_broker, false)
  encryption_in_transit_in_cluster    = try(var.encryption_in_transit_in_cluster, false)

  configuration_name              = var.configuration_name
  configuration_description       = var.configuration_description
  configuration_server_properties = var.configuration_server_properties

  jmx_exporter_enabled    = try(var.jmx_exporter_enabled, false)
  node_exporter_enabled   = try(var.node_exporter_enabled, false)
  cloudwatch_logs_enabled = try(var.cloudwatch_logs_enabled, false)
  s3_logs_enabled         = try(var.s3_logs_enabled, false)
  s3_logs_bucket          = try(var.s3_logs_bucket, null)
  s3_logs_prefix          = try(var.s3_logs_prefix, null)

  scaling_max_capacity = try(var.scaling_max_capacity, null)
  scaling_target_value = try(var.scaling_target_value, null)

  client_authentication                    = var.client_authentication
  create_scram_secret_association          = var.create_scram_secret_association
  scram_secret_association_secret_arn_list = var.scram_secret_association_secret_arn_list

  schema_registries = try(var.schema_registries, [])

  schemas = try(var.schemas, [])

  tags = var.tags
}
