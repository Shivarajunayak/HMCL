#rds
module "aurora" {
  source  = "./aws-rds-aurora"

  create                         = try(var.create, null)
  name                           = try(var.name, null)
  engine                         = try(var.engine, null)
  engine_version                 = try(var.engine_version, null)
  master_username                = try(var.master_username, null)
  master_password                = try(var.master_password, null)
  storage_type                   = try(var.storage_type, null)

  manage_master_user_password = try(var.manage_master_user_password, null)
  master_user_secret_kms_key_id = try(var.master_user_secret_kms_key_id, null)
  kms_key_id = try(var.kms_key_id, null)


  instances                      = try(var.instances, null)
  instance_class                 = try(var.instance_class, null)
  endpoints                      = try(var.endpoints, null)

  
  vpc_id                         = try(var.vpc_id, null)
  db_subnet_group_name           = try(var.db_subnet_group_name, null)
  create_db_subnet_group = try(var.create_db_subnet_group, null)
  subnets = try(var.subnets, null)

  security_group_rules           = try(var.security_group_rules, null)

  apply_immediately              = try(var.apply_immediately, null)
  skip_final_snapshot            = try(var.skip_final_snapshot, null)

  database_name                  = try(var.database_name, null)
  

  create_db_cluster_parameter_group      = try(var.create_db_cluster_parameter_group, null)
  db_cluster_parameter_group_name        = try(var.db_cluster_parameter_group_name, null)
  db_cluster_parameter_group_family      = try(var.db_cluster_parameter_group_family, null)
  db_cluster_parameter_group_description = try(var.db_cluster_parameter_group_description, null)
  db_cluster_parameter_group_parameters  = try(var.db_cluster_parameter_group_parameters, null)

  create_db_parameter_group      = try(var.create_db_parameter_group, null)
  db_parameter_group_name        = try(var.db_parameter_group_name, null)
  db_parameter_group_family      = try(var.db_parameter_group_family, null)
  db_parameter_group_description = try(var.db_parameter_group_description, null)
  db_parameter_group_parameters  = try(var.db_parameter_group_parameters, null)

  enabled_cloudwatch_logs_exports        = try(var.enabled_cloudwatch_logs_exports, null)
  create_cloudwatch_log_group            = try(var.create_cloudwatch_log_group, null)

  

  publicly_accessible            = try(var.publicly_accessible, null)
  create_monitoring_role = try(var.create_monitoring_role, null)

}