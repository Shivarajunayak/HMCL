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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/elasticache-redis?ref=feature_elasticache"
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

  create = true

  replication_group_id       = "hmcl-cv-${local.environment}-esync-replication-group"
  description                = "Elasticache Redis Replication Group ${local.environment}"
  availability_zones         = ["us-west-2a", "us-west-2b"]
  vpc_id                     = "vpc-0816899ffeac2813d"
  security_group_ids         = [dependency.sg.outputs.all_security_group_ids.redis_sg]
  subnets                    = ["subnet-05ae36ea89ae4ccc9", "subnet-0b407da0a83ecee01"]
  cluster_size               = 2
  instance_type              = "cache.t4g.micro"
  apply_immediately          = false
  automatic_failover_enabled = false
  engine_version             = "7.1"
  family                     = "redis7"
  at_rest_encryption_enabled = true
  kms_key_id                 = dependency.kms.outputs.key_arn
  transit_encryption_enabled = false


  elasticache_subnet_group_name = "hmcl-cv-${local.environment}-esync-subnet-group"
  create_parameter_group        = true
  parameter_group_name          = "hmcl-cv-${local.environment}-esync-parameter-group"
  parameter = [
    {
      name  = "notify-keyspace-events"
      value = "lK"
    }
  ]


  tags = {
    Owner          = "dev-team"
    project-name   = "connected-vehicle-platform"
    Name           = "hmcl-cv-${local.environment}-cloudfront"
    resource-type  = "cloudfront"
    resource-layer = "apps"
    account-name   = "${local.aws_account_name}"
    region         = "${local.aws_region}"
    env            = "${local.environment}"
    account-number = "${local.aws_account_id}"

    project-id          = "1"
    bu-criticality      = "low"
    data-classification = "internal"
    Terraform           = true
  }
}


dependency "kms" {
  config_path = "../../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}

dependency "sg" {
  config_path = "../../sgs"
  mock_outputs = {

    all_security_group_ids = {

      redis_sg = "sg-00e550564da3539ae"

    }
  }
}

