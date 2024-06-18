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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/athena?ref=feature-athena"
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


  bucket                     = "hmcl-cv-${local.environment}-athena-bucket"
  athena_db_name             = "hmcl_cv_${local.environment}_database"
  kms_key_arn                = dependency.kms.outputs.key_arn
  force_destroy              = true
  workgroup_name             = "hmcl-cv-${local.environment}-workgroup"
  enforce_workgroup_config   = true
  publish_cloudwatch_metrics = true
  output_location            = "s3://hmcl-cv-${local.environment}-athena-bucket/output"
  table_name                 = "hmcl-cv-${local.environment}-table"
  table_type                 = "EXTERNAL_TABLE"
  skip_header_line_count     = "1"
  input_format               = "org.apache.hadoop.mapred.TextInputFormat"
  output_format              = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
  serde_name                 = "SerDe"
  serialization_library      = "org.openx.data.jsonserde.JsonSerDe"
  serialization_format       = "1"
  columns = [
    { name = "column1", type = "string" },
    { name = "column2", type = "int" }
  ]
  named_query_name = "hmcl-cv-${local.environment}-query"
  query            = <<EOF
  "SELECT * FROM your_table_name"
  EOF

  tags = {
    Owner          = "dev-team"
    project-name   = "connected-vehicle-platform"
    Name           = "hmcl-cv-${local.environment}-athena"
    resource-type  = "athena"
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


