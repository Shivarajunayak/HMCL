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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/glue/glue-connectors?ref=feature_glue"
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

  vpc_availability_zone      = "us-west-2b"
  vpc_security_group_id_list = [dependency.sg.outputs.all_security_group_ids.glue_sg]
  vpc_subnet_id              = "subnet-09ca830d19eec175d"
  msk_connection_name        = "hmcl-cv-${local.environment}-msk-connector"
  network_connection_name    = "hmcl-cv-${local.environment}-network-connector"
  kafka_connection_properties = {

    "KAFKA_SSL_ENABLED"            = "false"
    "KAFKA_BOOTSTRAP_SERVERS"      = dependency.msk.outputs.bootstrap_brokers_sasl_iam
    "KAFKA_SASL_MECHANISM"         = "SCRAM-SHA-512"
    "KAFKA_SASL_SCRAM_SECRETS_ARN" = dependency.secretsmanager.outputs.all_secret_arns.msk_secret
  }


}

dependency "glue_s3" {
  config_path = "../../s3/glue-s3"
  mock_outputs = {
    s3_bucket_id = "hmcl-cv-dev-aps1-glue-bucket"
  }
}

dependency "sg" {
  config_path = "../../sgs"
  mock_outputs = {
    all_security_group_ids = {
      glue_sg = "sg-00e550564da3539ae"
    }
  }
}

dependency "msk" {
  config_path = "../../msk"
  mock_outputs = {
    msk_arn = "arn:aws:kafka:us-west-2:905418263290:cluster/hmcl-cv-dev-msk-cluster/765f2984-5d57-4d09-a529-ba8912d1d01e-4"
  }
}

dependency "secretsmanager" {
  config_path = "../../secretsmanager"

  mock_outputs = {
    all_secret_arns = {

      msk_secret  = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
      test_secret = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

    }
  }
}