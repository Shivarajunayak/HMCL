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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/parameter-store?ref=main"
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

  parameters = {

    iot_intermediate_ca = {
      create = true
      name   = "hmcl-cv-${local.environment}-iot-acmpca-intermediate-ca"
      value  = "arn:aws:acm-pca:us-west-2:905418263290:certificate-authority/1545314a-1d11-4d56-9bae-18bd6fbfa07e"
      key_id = dependency.kms.outputs.key_arn
      type   = "SecureString"
      tier   = "Standard"
      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-iot-intermediate-ca"
        resource-type  = "parameter-store"
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
    },

    param2 = {
      create = true
      name   = "hmcl-cv-${local.environment}-ssm-parameter-list"
      values = ["value1", "value2"]
      type   = "StringList"
      tier   = "Standard"
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

  }

}




dependency "kms" {
  config_path = "../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}

