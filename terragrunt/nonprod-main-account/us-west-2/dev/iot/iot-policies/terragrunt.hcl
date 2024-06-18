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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/iot/iot-policies?ref=feature_iot"

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

  iot_policies = {

    hmcl-cv-preprovisioning-cert-iot-policy = {

      name = "hmcl-cv-${local.environment}-preprovisioning-cert-iot-policy"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = ["iot:RegisterCertificate",
              "iot:AttachPolicy",
            "iot:DescribeEndpoint"]
            Resource = "*"
          },
          {
            Effect   = "Allow"
            Action   = ["iot:Publish"]
            Resource = ["arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/connection-check"]
          },
          {
            Effect = "Allow"
            Action = ["iot:Subscribe"]
            Resource = [
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topicfilter/hmcl/tcu/+/connection-check/accepted",
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topicfilter/hmcl/tcu/+/connection-check/rejected"
            ]
          },
          {
            Effect = "Allow"
            Action = ["iot:Receive"]
            Resource = [
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/connection-check/accepted",
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/connection-check/rejected"
            ]
          }

        ]
      })

    },


    hmcl-cv-vehicle-cert-rotation-iot-policy = {

      name = "hmcl-cv-${local.environment}-vehicle-cert-rotation-iot-policy"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = ["iot:Connect"],
            Condition = {
              Bool = {
                "iot:Connection.Thing.IsAttached" : "true"
              }
            },
            Resource = ["arn:aws:iot:${local.aws_region}:${local.aws_account_id}:client/*"]
          },
          {
            Effect   = "Allow"
            Action   = ["iot:Publish"]
            Resource = ["arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/rotation/csr"]
          },
          {
            Effect = "Allow"
            Action = ["iot:Subscribe"]
            Resource = [
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topicfilter/hmcl/tcu/+/rotation/csr-req",
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topicfilter/hmcl/tcu/+/rotation/crt"
            ]
          },
          {
            Effect = "Allow"
            Action = ["iot:Receive"]
            Resource = [
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/hmcl/tcu/+/rotation/csr-req",
              "arn:aws:iot:${local.aws_region}:${local.aws_account_id}:topic/hmcl/tcu/+/rotation/crt"
            ]
          }

        ]
      })

    }

  }

  tags = {
    Owner          = "iot-team"
    project-name   = "connected-vehicle-platform"
    Name           = "hmcl-cv-${local.environment}-iot-policy"
    resource-type  = "iot-policy"
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




