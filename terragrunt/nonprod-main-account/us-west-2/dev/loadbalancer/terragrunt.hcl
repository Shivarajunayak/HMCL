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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/loadbalancer?ref=feature_nlb"

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

  network_load_balancers = {

    lb_1 = {

      lb_name            = "nlb1"
      internal           = true
      load_balancer_type = "network"
      subnets            = ["subnet-06fcef4b6f71ebe4b", "subnet-046af167eaf413237"]
      delete_protection  = false
      target_groups = {
        "lb8080" = {
          name        = "lb-8080"
          port        = 8080
          protocol    = "TCP"
          vpc_id      = "vpc-0816899ffeac2813d"
          target_type = "ip"
        }
      }
      security_groups = ["sg-0324f08b29253c6fb"]
      listeners = {
        "lb80" = {
          port         = 80
          protocol     = "TCP"
          target_group = "lb8080"
        }
      }
      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-nlb1"
        resource-type  = "nlb"
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




