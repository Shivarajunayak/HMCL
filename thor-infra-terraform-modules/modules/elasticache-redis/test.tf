module "redis" {
  source = "./aws-elasticache-redis"

  availability_zones                   = try(var.availability_zones, [])
  description                          = try(var.description, null)
  zone_id                              = try(var.zone_id, [])
  vpc_id                               = try(var.vpc_id, "")
  subnets                              = try(var.subnets, [])
  elasticache_subnet_group_name        = try(var.elasticache_subnet_group_name, "")
  replication_group_id                 = try(var.replication_group_id, "")
  cluster_size                         = try(var.cluster_size, 1)
  instance_type                        = try(var.instance_type, "cache.t2.micro")
  port                                 = try(var.port, 6379)
  apply_immediately                    = try(var.apply_immediately, false)
  automatic_failover_enabled           = try(var.automatic_failover_enabled, false)
  auto_minor_version_upgrade           = try(var.auto_minor_version_upgrade, false)
  multi_az_enabled                     = try(var.multi_az_enabled, false)
  engine_version                       = try(var.engine_version, "4.0.10")
  family                               = try(var.family, "")
  at_rest_encryption_enabled           = try(var.at_rest_encryption_enabled, true)
  transit_encryption_enabled           = try(var.transit_encryption_enabled, true)
  kms_key_id                           = try(var.kms_key_id, null)
  cluster_mode_enabled                 = try(var.cluster_mode_enabled, false)
  cluster_mode_replicas_per_node_group = try(var.cluster_mode_replicas_per_node_group, 0)
  cluster_mode_num_node_groups         = try(var.cluster_mode_num_node_groups, 0)

  cloudwatch_metric_alarms_enabled = try(var.cloudwatch_metric_alarms_enabled, false)
  create_parameter_group           = try(var.create_parameter_group, true)
  parameter_group_description      = try(var.parameter_group_description, null)
  parameter_group_name             = try(var.parameter_group_name, null)
  log_delivery_configuration       = try(var.log_delivery_configuration, [])
  user_group_ids                   = try(var.user_group_ids, null)

  maintenance_window           = try(var.maintenance_window, "")
  notification_topic_arn       = try(var.notification_topic_arn, "")
  alarm_cpu_threshold_percent  = try(var.alarm_cpu_threshold_percent, 75)
  alarm_memory_threshold_bytes = try(var.alarm_memory_threshold_bytes, 10000000)
  alarm_actions                = try(var.alarm_actions, [])
  ok_actions                   = try(var.ok_actions, [])

  data_tiering_enabled      = try(var.data_tiering_enabled, false)
  dns_subdomain             = try(var.dns_subdomain, "")
  auth_token                = try(var.auth_token, null)
  snapshot_arns             = try(var.snapshot_arns, [])
  snapshot_name             = try(var.snapshot_name, null)
  snapshot_window           = try(var.snapshot_window, "")
  snapshot_retention_limit  = try(var.snapshot_retention_limit, 0)
  final_snapshot_identifier = try(var.final_snapshot_identifier, null)


  parameter = try(var.parameter, [])
  tags      = var.tags


}
