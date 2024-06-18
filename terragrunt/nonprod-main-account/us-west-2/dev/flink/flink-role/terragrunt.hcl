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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/flink/flink-role?ref=feature_flink"
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

  iam_role_name          = "hmcl-cv-${local.environment}-${local.aws_region_short}-flink-role"
  iam_policy_name        = "hmcl-cv-${local.environment}-${local.aws_region_short}-flink-policy"
  iam_policy_description = "Custom policy for Flink role"
  custom_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kafka:CreateVpcConnection",
          "kafka:GetBootstrapBrokers",
          "kafka:DescribeCluster",
          "kafka:DescribeClusterV2",
          "kafka-cluster:Connect"
        ]
        Resource = [
          dependency.msk.outputs.msk_arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kafka-cluster:DescribeTopic",
          "kafka-cluster:DescribeTopicDynamicConfiguration",
          "kafka-cluster:ReadData",
          "kafka-cluster:WriteData",
          "kafka-cluster:*"
        ]
        Resource = [
          "${dependency.msk.outputs.msk_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "kafka-cluster:DescribeGroup",
          "kafka-cluster:*"
        ]
        Resource = [
          "${dependency.msk.outputs.msk_arn}/*"
        ]
      },
      {
        Sid    = "ReadCode"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [
          dependency.flink_s3.outputs.s3_bucket_arn,
          "${dependency.flink_s3.outputs.s3_bucket_arn}/*"
        ]
      },
      {
        Sid    = "ListCloudwatchLogGroups"
        Effect = "Allow"
        Action = [
          "logs:DescribeLogGroups"
        ]
        Resource = [
          "arn:aws:logs:us-east-1:905418263290:log-group:*"
        ]
      },
      {
        Sid    = "ListCloudwatchLogStreams"
        Effect = "Allow"
        Action = [
          "logs:DescribeLogStreams",
          "cloudwatch:PutMetricData"
        ]
        Resource = [
          "arn:aws:logs:us-east-1:905418263290:log-group:/aws/kinesis-analytics/*:*"
        ]
      },
      {
        Sid    = "PutCloudwatchLogs"
        Effect = "Allow"
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups"
        ]
        Resource = [
          "arn:aws:logs:us-east-1:905418263290:log-group:/aws/kinesis-analytics/*:*"
        ]
      },
      {
        Sid    = "VPCReadOnlyPermissions"
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeDhcpOptions"
        ]
        Resource = "*"
      },
      {
        Sid    = "ENIReadWritePermissions"
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:CreateNetworkInterfacePermission",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })

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


dependency "flink_s3" {
  config_path = "../../s3/flink-s3"
  mock_outputs = {
    s3_bucket_arn = "hmcl-cv-dev-aps1-flink-code-bucket"
  }
}


dependency "sg" {
  config_path = "../../sgs"
  mock_outputs = {
    all_security_group_ids = {
      flink_sg = "sg-00e550564da3539ae"
    }
  }
}


dependency "msk" {
  config_path = "../../msk"
  mock_outputs = {
    bootstrap_brokers_sasl_iam = "ede"
  }
}

