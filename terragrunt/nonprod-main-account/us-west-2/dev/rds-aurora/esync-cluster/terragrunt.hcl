# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.


include "root" {
  path = find_in_parent_folders()
}


# Configure the version of the module to use in this environment. This allows you to promote new versions one
# environment at a time (e.g., qa -> stage -> prod).

terraform {
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/rds-aurora?ref=feature_rds"
}

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))


  # Extract the variables we need for easy access

  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_account_name = local.account_vars.locals.account_name
  aws_region       = local.region_vars.locals.aws_region
  aws_region_short = local.region_vars.locals.aws_region_short
  sso_region       = local.region_vars.locals.sso_region
  deployment_role  = local.account_vars.locals.deployment_role
  environment      = local.environment_vars.locals.environment
}


# Inputs to the source Terraform module

inputs = {
  name                        = "hmcl-cv-${local.environment}-esync-cluster"
  engine                      = "aurora-postgresql"
  engine_version              = "16.2"
  allow_major_version_upgrade = true
  master_username             = "root"
  manage_master_user_password = true
  database_name               = "thor_esync_db"
  storage_type                = "aurora-iopt1"
  instances = {
    1 = {
      identifier          = "esync-instance-1"
      instance_class      = "db.r6g.large"
      publicly_accessible = false
    }

  }
  endpoints = {

  }

  master_user_secret_kms_key_id = dependency.kms.outputs.key_arn
  kms_key_id                    = dependency.kms.outputs.key_arn


  vpc_id                 = "vpc-0816899ffeac2813d"
  db_subnet_group_name   = "hmcl-cv-${local.environment}-esync-db-subnet-group"
  create_db_subnet_group = true
  subnets                = ["subnet-05ae36ea89ae4ccc9", "subnet-0b407da0a83ecee01"]
  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = ["10.62.128.0/19"]
    }
  }
  apply_immediately                      = false
  skip_final_snapshot                    = true
  preferred_maintenance_window           = "sun:00:00-sun:01:00"
  preferred_backup_window                = "02:00-03:00"
  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = "hmcl-cv-${local.environment}-esync-cluster-parameter-group"
  db_cluster_parameter_group_family      = "aurora-postgresql16"
  db_cluster_parameter_group_description = "esync cluster parameter group"
  db_cluster_parameter_group_parameters = [
    {
      name         = "log_min_duration_statement"
      value        = 4000
      apply_method = "immediate"
    },
    {
      name         = "rds.force_ssl"
      value        = 0
      apply_method = "immediate"
    }
  ]
  create_db_parameter_group      = true
  db_parameter_group_name        = "hmcl-cv-${local.environment}-esync-parameter-group"
  db_parameter_group_family      = "aurora-postgresql16"
  db_parameter_group_description = "esync DB parameter group"
  db_parameter_group_parameters = [
    {
      name         = "log_min_duration_statement"
      value        = 4000
      apply_method = "immediate"
    }
  ]
  enabled_cloudwatch_logs_exports = []
  create_cloudwatch_log_group     = true
  publicly_accessible             = false


}



dependency "kms" {
  config_path = "../../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}


