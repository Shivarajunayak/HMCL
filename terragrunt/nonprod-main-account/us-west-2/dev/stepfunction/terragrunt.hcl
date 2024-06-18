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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/stepfunctions?ref=feature_stepfunctions"
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
  name = "hmcl-cv-${local.environment}-stepfunction"
  type = "STANDARD"
  tags = {
    Owner               = "dev-team"
    project-name        = "connected-vehicle-platform"
    Name                = "hmcl-cv-${local.environment}-stepfunction"
    resource-type       = "stepfunction"
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
  definition = <<EOF
{
  "StartAt": "Step1",
  "States": {
    "Step1": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-west-1:123456789012:function:test5",
      "Parameters": {
        "param1.$": "$.param1_step1",
        "param2.$": "$.param2_step1"
      },
      "Next": "Step2"
    },
    "Step2": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-west-1:123456789012:function:test1",
      "Parameters": {
        "param1.$": "$.param1_step2",
        "param2.$": "$.param2_step2"
      },
      "Next": "Step3"
    },
    "Step3": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-west-1:123456789012:function:test2",
      "Parameters": {
        "param1.$": "$.param1_step3",
        "param2.$": "$.param2_step3"
      },
      "Next": "Step4"
    },
    "Step4": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-west-1:123456789012:function:test3",
      "Parameters": {
        "param1.$": "$.param1_step4",
        "param2.$": "$.param2_step4"
      },
      "Next": "Step5"
    },
    "Step5": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:eu-west-1:123456789012:function:test4",
      "Parameters": {
        "param1.$": "$.param1_step5",
        "param2.$": "$.param2_step5"
      },
      "End": true
    }
  }
}
EOF
  service_integrations = {
    dynamodb = {
      dynamodb = ["arn:aws:dynamodb:eu-west-1:052212379155:table/Test"]
    }
    lambda = {
      lambda = [
        "arn:aws:lambda:eu-west-1:123456789012:function:test1",
        "arn:aws:lambda:eu-west-1:123456789012:function:test2",
        "arn:aws:lambda:eu-west-1:123456789012:function:test3",
        "arn:aws:lambda:eu-west-1:123456789012:function:test4",
        "arn:aws:lambda:eu-west-1:123456789012:function:test5"
      ]
    }
    stepfunction_Sync = {
      stepfunction          = ["arn:aws:states:eu-west-1:123456789012:stateMachine:test1"]
      stepfunction_Wildcard = ["arn:aws:states:eu-west-1:123456789012:stateMachine:test1"]
    }
  }
}