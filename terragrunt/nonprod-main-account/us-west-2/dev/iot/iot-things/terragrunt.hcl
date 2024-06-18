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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/iot/iot-things?ref=feature_iot"

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

  things = [
    {
      name             = "HMCL-MPARITOS-1"
      attribute_keys   = ["TenantId", "VirtualId"]
      attribute_values = ["EV", "fc05920a-920a-45920ae60e-85920ae60e67f-67f107"]
      tags             = { environment = "dev", project = "iot" }
    },
    {
      name             = "thing2"
      attribute_keys   = ["First", "Second"]
      attribute_values = ["value3", "value4"]
      tags             = { environment = "prod", project = "iot" }
    }
  ]
  thing_groups = [
    {
      name             = "EV-hmcl-cvp-device-provisioning"
      parent_name      = ""
      attribute_keys   = []
      attribute_values = []
      description      = ""
      tags             = { terraform = "true" }
    },
    {
      name             = "group2"
      parent_name      = "group1"
      attribute_keys   = ["One", "Two"]
      attribute_values = ["11111", "22222"]
      description      = "This is my second thing group"
      tags             = { terraform = "true" }
    }
  ]

}




