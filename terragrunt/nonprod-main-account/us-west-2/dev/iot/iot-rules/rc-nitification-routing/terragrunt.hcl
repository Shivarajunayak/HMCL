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
      rule_name   = "hmcl_cv_${local.environment}_rc_notification_routing"
      sql         = "SELECT *, vehicleId as tcuId FROM '$aws/iotfleetwise/gamma-us-west-2/vehicles/+/command/notification'"
      sql_version = "2016-03-23"
      description = "hmcl_cv_dev_rc_notification_routing"
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
            Effect = "Allow"
            Action = [
              "logs:CreateLogStream",
              "logs:DescribeLogStreams",
              "logs:PutLogEvents"
            ]
            Resource = [
              "arn:aws:logs:us-east-1:${local.aws_account_id}:log-group:AWSIotLogsV2:*"
            ]
          },
          {
            "Effect" : "Allow",
            "Action" : [
              "ec2:CreateNetworkInterface",
              "ec2:DescribeNetworkInterfaces",
              "ec2:DescribeVpcs",
              "ec2:DeleteNetworkInterface",
              "ec2:DescribeSubnets",
              "ec2:DescribeVpcAttribute",
              "ec2:DescribeSecurityGroups"
            ],
            "Resource" : "*"
          },
          {
            "Effect" : "Allow",
            "Action" : "ec2:CreateNetworkInterfacePermission",
            "Resource" : "*",
            "Condition" : {
              "StringEquals" : {
                "ec2:ResourceTag/VPCDestinationENI" : "true"
              }
            }
          },
          {
            "Effect" : "Allow",
            "Action" : [
              "ec2:CreateTags"
            ],
            "Resource" : "*",
            "Condition" : {
              "StringEquals" : {
                "ec2:CreateAction" : "CreateNetworkInterface",
                "aws:RequestTag/VPCDestinationENI" : "true"
              }
            }
          },
          {
            "Effect" : "Allow",
            "Action" : [
              "kms:Decrypt",
              "kms:Encrypt",
              "kms:GenerateDataKey",
              "kms:DescribeKey",
              "kms:CreateGrant"
            ],
            "Resource" : "*"
          },
          {
            "Effect" : "Allow",
            "Action" : [
              "secretsmanager:GetSecretValue",
              "secretsmanager:DescribeSecret",
              "secretsmanager:ListSecrets"
            ],
            "Resource" : "*"
          }
        ]
      })
      action = {
        kafka = {
          destination_arn = dependency.destinations.outputs.iot_topic_rule_destination_arn
          topic           = "hmcl-cv-dev-rc-notification-routing"
          key             = ""
          client_properties = {
            bootstrap_servers = dependency.msk.outputs.bootstrap_brokers_sasl_iam
            security_protocol = "SASL_SSL"
            sasl_mechanism    = "SCRAM-SHA-512"
            sasl_secret_name  = "AmazonMSK_hmcl-cv-${local.environment}-msk-secret"
            acks              = "1"
            compression_type  = "none"
          }
        },
        republish = {
          topic    = "accepted"
          role_arn = "arn:aws:iam::${local.aws_account_id}:role/hmcl_cv_${local.environment}_rc_notification_routing"
          qos      = 1
        }
      }
      error_action = {
        cloudwatch_logs = {
          log_group_name = "AWSIotLogsV2"
        }
      }

      tags = {
        Owner               = "dev-team"
        project-name        = "connected-vehicle-platform"
        Name                = "hmcl-cv-${local.environment}-rc-notification-routing"
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



dependency "destinations" {
  config_path = "../../iot-destinations"
  mock_outputs = {
    iot_topic_rule_destination_arn = "arn:aws:iot:us-east-1:905418263290:ruledestination/vpc/d167a1df-46f3-4c02-89be-fa7f1e061798"
  }
}

dependency "msk" {
  config_path = "../../../msk"
  mock_outputs = {
    bootstrap_brokers_sasl_iam = "arn"
  }
}

dependency "secretsmanager" {
  config_path = "../../../secretsmanager"

  mock_outputs = {
    all_secret_arns = {

      msk_secret  = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
      test_secret = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

    }
  }
}