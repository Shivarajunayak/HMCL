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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/msk"
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

  name                   = "hmcl-cv-${local.environment}-msk-cluster"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 2

  broker_node_client_subnets = ["subnet-09ca830d19eec175d", "subnet-0b6740a481f50a6a6"]
  broker_node_storage_info = {
    ebs_storage_info = {
      volume_size = 100
    }
  }
  broker_node_instance_type   = "kafka.m5.large"
  broker_node_security_groups = [dependency.sg.outputs.all_security_group_ids.msk_sg]

  encryption_at_rest_kms_key_arn      = dependency.kms.outputs.key_arn
  encryption_in_transit_client_broker = "TLS"
  encryption_in_transit_in_cluster    = true


  configuration_name        = "hmcl-cv-${local.environment}-msk-config"
  configuration_description = "Kafka cluster configuration"

  configuration_server_properties = {
    "auto.create.topics.enable"      = true
    "delete.topic.enable"            = true
    "default.replication.factor"     = 3
    "min.insync.replicas"            = 2
    "num.io.threads"                 = 8
    "num.network.threads"            = 5
    "num.partitions"                 = 1
    "num.replica.fetchers"           = 2
    "replica.lag.time.max.ms"        = 30000
    "socket.receive.buffer.bytes"    = 102400
    "socket.request.max.bytes"       = 104857600
    "socket.send.buffer.bytes"       = 102400
    "unclean.leader.election.enable" = true
    "zookeeper.session.timeout.ms"   = 18000
    "compression.type"               = "snappy"
  }

  jmx_exporter_enabled                   = false
  node_exporter_enabled                  = false
  cloudwatch_logs_enabled                = true
  cloudwatch_log_group_retention_in_days = 1
  cloudwatch_log_group_kms_key_id        = dependency.kms.outputs.key_arn

  s3_logs_enabled = false
  s3_logs_bucket  = ""
  s3_logs_prefix  = ""

  enable_storage_autoscaling = true
  scaling_max_capacity       = 10
  scaling_target_value       = 70

  client_authentication = {
    sasl = {
      scram = true
      iam   = true
    }
  }
  create_scram_secret_association          = true
  scram_secret_association_secret_arn_list = [dependency.secretsmanager.outputs.all_secret_arns.msk_secret]


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


dependency "secretsmanager" {
  config_path = "../secretsmanager"

  mock_outputs = {
    all_secret_arns = {

      msk_secret  = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
      test_secret = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

    }
  }
}

dependency "kms" {
  config_path = "../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}

dependency "sg" {
  config_path = "../sgs"
  mock_outputs = {

    all_security_group_ids = {

      msk_sg = "sg-00e550564da3539ae"

    }
  }
}