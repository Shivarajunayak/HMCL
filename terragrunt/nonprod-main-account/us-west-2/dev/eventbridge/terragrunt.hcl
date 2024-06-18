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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/eventbridge?ref=feature_eventbridge"
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
  bus_name       = "hmcl-cv-${local.environment}-eventbridge"
  create_targets = true
  rules = {
    logs = {
      description   = "Capture log data"
      event_pattern = jsonencode({ "source" : ["my.app.logs"] })
    }
  }
  targets = {
    logs = [
      {
        name = "send-logs-to-sqs"
        arn  = "dependency.sqs.outputs.all_sqs_queue_arns.log_queue"
      },
      {
        name = "send-logs-to-cloudwatch"
        arn  = "dependency.cloudwatch.outputs.cloudwatch_log_group_name.cloudwatch_log_group_arn"
      }
    ]
  }

  tags = {
    Owner          = "dev-team"
    project-name   = "connected-vehicle-platform"
    Name           = "hmcl-cv-${local.environment}-eventbridge"
    resource-type  = "eventbridge"
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



dependency "sqs" {
  config_path = "../sqs"
  mock_outputs = {
    all_sqs_queue_arns = {
      log_queue = "arn:aws:sqs:ap-south-1:637423293078:karpenter-hmcl-cv-shared-cluster"
    }
  }
}
dependency "cloudwatch" {
  config_path = "../cloudwatch"
  mock_outputs = {
    cloudwatch_log_group_name = {
      cloudwatch_log_group_arn = "arn:aws:logs:ap-south-1:637423293078:log-group:eventbridge:*"
    }
  }
}



