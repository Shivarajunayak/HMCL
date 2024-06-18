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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/secretsmanager"
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

  secrets = {
    msk_secret = {
      name                           = "AmazonMSK_hmcl-cv-${local.environment}-msk-secret"
      kms_key_id                     = dependency.kms.outputs.key_arn
      description                    = "MSK secret"
      force_overwrite_replica_secret = true
      secret_key_value = {
        username = "user"
        password = "topsecret"
      }
      recovery_window_in_days = 0
    },
    claim_certificate_secret = {
      name                           = "hmcl-cv-${local.environment}-claim-certificate"
      kms_key_id                     = dependency.kms.outputs.key_arn
      description                    = "Claim Certificate Secret"
      force_overwrite_replica_secret = true
      secret_key_value = {
        username = "user"
        password = "topsecret"
      }
      rotation_enabled         = true
      rotation_lambda_arn      = "arn:aws:lambda:${local.aws_region}:${local.aws_account_id}:function:hmcl-cv-${local.environment}-preprovisioning-cert-gen-lambda"
      automatically_after_days = 90
      recovery_window_in_days  = 0
    },
    opensearch_secret = {
      name                           = "hmcl-cv-${local.environment}-opensearch-secret"
      kms_key_id                     = dependency.kms.outputs.key_arn
      description                    = "${local.environment} Opensearch Credentials"
      force_overwrite_replica_secret = true
      secret_key_value = {
        username = "opensearch${local.environment}user"
        password = "opensearchhmcl${local.environment}password!"
      }
      recovery_window_in_days = 0
    },
    secret_1 = {
      name                           = "test-string-secret"
      kms_key_id                     = dependency.kms.outputs.key_arn # by default aws/secretsmanager is leveraged
      description                    = "My secret 1"
      force_overwrite_replica_secret = true
      recovery_window_in_days        = 0
      secret_string                  = "This is an example"
    },
    secret_binary = {
      name                           = "test-binary-secret"
      kms_key_id                     = dependency.kms.outputs.key_arn # by default aws/secretsmanager is leveraged
      description                    = "This is a binary secret"
      force_overwrite_replica_secret = true
      secret_binary                  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzc818NSC6oJYnNjVWoF43+IuQpqc3WyS8BWZ50uawK5lY/aObweX2YiXPv2CoVvHUM0vG7U7BDBvNi2xwsT9n9uT27lcVQsTa8iDtpyoeBhcj3vJ60Jd04UfoMP7Og6UbD+KGiaqQ0LEtMXq6d3i619t7V0UkaJ4MXh2xl5y3bV4zNzTXdSScJnvMFfjLW0pJOOqltLma3NQ9ILVdMSK2Vzxc87T+h/jp0VuUAX4Rx9DqmxEU/4JadXmow/BKy69KVwAk/AQ8jL7OwD2YAxlMKqKnOsBJQF27YjmMD240UjkmnPlxkV8+g9b2hA0iM5GL+5MWg6pPUE0BYdarCmwyuaWYhv/426LnfHTz9UVC3y9Hg5c4X4I6AdJJUmarZXqxnMe9jJiqiQ+CAuxW3m0gIGsEbUul6raG73xFuozlaXq3J+kMCVW24eG2i5fezgmtiysIf/dpcUo+YLkX+U8jdMQg9IwCY0bf8XL39kwJ7u8uWU8+7nMcS9VQ5llVVMk= lgallard@server2"
      recovery_window_in_days        = 0
    }
  }

  tags = {
    Owner          = "dev-team"
    project-name   = "connected-vehicle-platform"
    Name           = "hmcl-cv-${local.environment}-secrets"
    resource-type  = "secretsmanager"
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



dependency "kms" {
  config_path = "../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}

