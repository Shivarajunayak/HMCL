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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/s3"
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

  create_bucket         = true
  is_lambda_code_bucket = false
  bucket                = "hmcl-cv-${local.environment}-${local.aws_region}-raw"

  force_destroy       = true
  acceleration_status = "Suspended"
  request_payer       = "BucketOwner"
  versioning = {
    status     = true
    mfa_delete = false
  }
  object_lock_enabled = false
  object_lock_configuration = {
  }
  attach_policy = true

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
      "AWS": [
        "arn:aws:iam::905418263290:role/hmcl-cv-dev-usw2-glue-role",
        "arn:aws:iam::637423615990:user/lf-data-engineer",
        "arn:aws:iam::905418263290:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_AdministratorAccess_7bfca4206085685b",
        "arn:aws:iam::905418263290:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_lf-data-engineer_0afc850a41a1b315",
        "arn:aws:iam::637423615990:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_lf-data-scientist_f98405ac4446fc32",
        "arn:aws:iam::637423615990:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_lf-data-analyst_b37969a92a244334",
        "arn:aws:iam::637423615990:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_lf-data-engineer_7d316a6549862ee1",
        "arn:aws:iam::637423615990:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_AdministratorAccess_ef0d80c705afe482"
      ]
      },
      "Action": "s3:*",
      "Resource": ["arn:aws:s3:::hmcl-cv-${local.environment}-${local.aws_region}-raw","arn:aws:s3:::hmcl-cv-${local.environment}-${local.aws_region}-raw/*"]
      
    }
  ]
}
POLICY


  attach_deny_insecure_transport_policy    = false
  attach_require_latest_tls_policy         = false
  attach_deny_incorrect_encryption_headers = false
  attach_deny_incorrect_kms_key_sse        = false
  attach_deny_unencrypted_object_uploads   = false
  control_object_ownership                 = false
  object_ownership                         = "BucketOwnerPreferred"
  server_side_encryption_configuration     = {}
  lifecycle_rule                           = []
  intelligent_tiering                      = {}
  metric_configuration                     = []


  tags = {
    Owner          = "dev-team"
    project-name   = "connected-vehicle-platform"
    Name           = "hmcl-cv-${local.environment}-s3"
    resource-type  = "s3"
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
