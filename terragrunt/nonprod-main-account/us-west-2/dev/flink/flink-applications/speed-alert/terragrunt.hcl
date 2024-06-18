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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/flink/flink-applications?ref=feature_flink"
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
  bucket              = dependency.flink_s3.outputs.s3_bucket_arn
  s3_object_key       = "flink_code_v2/dynamicnotification-1.0.0-SNAPSHOT-v2.jar"
  application_name    = "hmcl-cv-${local.environment}-speed-alert"
  runtime_environment = "FLINK-1_18"

  flink_application_properties = [
    {
      property_group_id = "FlinkApplicationProperties"
      property_map = {
        "kafka.output.sink.bootstrap.brokers"        = dependency.msk.outputs.bootstrap_brokers_sasl_iam
        "kafka.output.topic"                         = "OUTPUT_THOR"
        "aws.region"                                 = "${local.aws_region}"
        "is.run.test.case"                           = "FALSE"
        "kafka.rules.group.idc"                      = "rulesGroup"
        "kafka.rules.role.arn"                       = dependency.flink_role.outputs.flink_role_arn
        "window.time.size.insec"                     = "15"
        "max.out.of.orderness.insec"                 = "5"
        "kafka.rules.session.name"                   = "teleJSONSession"
        "kafka.telemetry.bootstrap.brokers"          = dependency.msk.outputs.bootstrap_brokers_sasl_iam
        "kafka.telemetry.group.id"                   = "teleGroup"
        "kafka.telemetry.input.topic"                = "hmcl-thor-speed-alert-telemetry-v1"
        "kafka.telemetry.role.arn"                   = dependency.flink_role.outputs.flink_role_arn
        "kafka.telemetry.session.name"               = "OUTPUT_THOR"
        "kafka.threshold.group.id"                   = "teleJSONSession"
        "kafka.output.topic"                         = "teleGroup"
        "kafka.threshold.role.arn"                   = dependency.flink_role.outputs.flink_role_arn
        "kafka.threshold.session.name"               = "teleJSONSession"
        "kafka.userpref.rules.bootstrap.brokers"     = dependency.msk.outputs.bootstrap_brokers_sasl_iam
        "kafka.userpref.rules.input.topic"           = "hmcl-thor-speed-alert-rules"
        "kafka.userpref.threshold.bootstrap.brokers" = dependency.msk.outputs.bootstrap_brokers_sasl_iam
        "kafka.userpref.threshold.input.topic"       = "hmcl-thor-user-preference"
      }
    }
  ]

  flink_application_configuration = [
    {
      checkpoint_configuration_type  = "DEFAULT"
      monitoring_configuration_type  = "CUSTOM"
      log_level                      = "INFO"
      metrics_level                  = "APPLICATION"
      auto_scaling_enabled           = true
      parallelism_configuration_type = "CUSTOM"
      parallelism                    = 2
      parallelism_per_kpu            = 2
    }
  ]
  vpc_id                = "vpc-00038ad12d3dd001f"
  subnet_ids            = ["subnet-09ca830d19eec175d", "subnet-0b6740a481f50a6a6"]
  security_group_id     = dependency.sg.outputs.all_security_group_ids.flink_sg
  cloudwatch_log_group  = "/aws/kinesisanalytics/hmcl-cv-${local.environment}-speed-alert"
  cloudwatch_log_stream = "hmcl-cv-${local.environment}-speed-alert"

  flink_role_arn = dependency.flink_role.outputs.flink_role_arn


  tags = {
    Owner               = "dev-team"
    project-name        = "connected-vehicle-platform"
    Name                = "hmcl-cv-${local.environment}-speed-alert"
    resource-type       = "flink"
    resource-layer      = "apps"
    account-name        = "${local.aws_account_name}"
    region              = "${local.aws_region}"
    env                 = "${local.environment}"
    account-number      = "${local.aws_account_id}"
    project-id          = "1"
    bu-criticality      = "low"
    data-classification = "internal"
    Terraform           = true
  }
}




dependency "flink_role" {
  config_path = "../../flink-role"
  mock_outputs = {
    flink_role_arn = "arn"
  }
}

dependency "flink_s3" {
  config_path = "../../../s3/flink-s3"
  mock_outputs = {
    s3_bucket_arn = "hmcl-cv-dev-aps1-flink-code-bucket"
  }
}


dependency "sg" {
  config_path = "../../../sgs"
  mock_outputs = {
    all_security_group_ids = {
      flink_sg = "sg-00e550564da3539ae"
    }
  }
}


dependency "msk" {
  config_path = "../../../msk"
  mock_outputs = {
    bootstrap_brokers_sasl_iam = "ede"
  }
}

