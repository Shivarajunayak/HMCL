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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/iot/iot-rules?ref=feature_iot"

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
  iot_topic_rules = [
    {
      rule_name   = "hmcl_cv_${local.environment}_tcu_rule"
      sql         = "SELECT topic(3) as TCU_ID, IMEI, TCU_METADATA, timestamp() as TIMESTAMP FROM 'hmcl/tcu/+/connection-check' WHERE isNull(IMEI)=False"
      sql_version = "2016-03-23"
      description = "hmcl_cv_dev_tcu_rule"
      needs_iam   = true
      assume_role_policy_action = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Principal = {
              Service = "iot.amazonaws.com"
            }
            Action = "sts:AssumeRole"
          }
        ]
      })
      custom_policy_action = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            "Effect" : "Allow",
            "Action" : "dynamodb:PutItem",
            "Resource" : "arn:aws:dynamodb:${local.aws_region}:${local.aws_account_id}:table/hmcl_cv_dev_tcu"
          },
          {
            "Effect" : "Allow",
            "Action" : "iot:Publish",
            "Resource" : "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/connection-check/accepted"
          },
          {
            "Effect" : "Allow",
            "Action" : "iot:Publish",
            "Resource" : "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/connection-check/rejected"
          },
          {
            "Action" : [
              "dynamodb:PutItem",
              "dynamodb:GetItem",
              "dynamodb:UpdateItem"
            ],
            "Effect" : "Allow",
            "Resource" : "arn:aws:dynamodb:${local.aws_region}:${local.aws_account_id}:table/hmcl_cv_dev_tcu"
          },
          {
            "Action" : [
              "logs:CreateLogStream",
              "logs:DescribeLogStreams",
              "logs:PutRetentionPolicy",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ],
            "Effect" : "Allow",
            "Resource" : "arn:aws:logs:*:*:log-group:*"
          },
          {
            "Action" : "iot:*",
            "Effect" : "Allow",
            "Resource" : "*"
          }
        ]
      })
      action = {
        dynamodb = {
          table_name     = "hmcl_cv_dev_tcu"
          hash_key_field = "TCU_ID"
          hash_key_value = "5"
        },
        republish = {
          topic    = "accepted"
          role_arn = "arn:aws:iam::${local.aws_account_id}:role/hmcl_cv_${local.environment}_tcu_rule"
          qos      = 1
        }
      }
      error_action = {
        republish = {
          topic    = "rejected"
          role_arn = "arn:aws:iam::${local.aws_account_id}:role/hmcl_cv_${local.environment}_tcu_rule"
          qos      = 1
        }
      }

      tags = {
        Owner               = "dev-team"
        project-name        = "connected-vehicle-platform"
        Name                = "hmcl-cv-${local.environment}-tcu-rule"
        resource-type       = "iot-rules"
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
  ]
}
