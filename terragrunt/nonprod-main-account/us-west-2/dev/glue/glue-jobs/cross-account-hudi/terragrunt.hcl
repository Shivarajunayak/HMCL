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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/glue/glue-jobs?ref=feature_glue"
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

  glue_version      = "4.0"
  job_name          = "hmcl-cv-${local.environment}-job-hudi-cross-account"
  job_description   = "job-hudi-cross-account"
  glue_role_arn     = dependency.glue_role.outputs.glue_role_arn
  worker_type       = "G.1X"
  number_of_workers = 10
  max_retries       = 0
  timeout           = null
  s3_object_key     = ["scripts/", "temporary/"]
  data_location     = "s3://my-data-bucket/data/"
  connections       = dependency.glue_connectors.outputs.connections

  default_arguments         = {}
  non_overridable_arguments = {}
  security_configuration    = null
  command = {
    name            = "gluestreaming"
    script_location = "s3://${dependency.glue_s3.outputs.s3_bucket_id}/hmcl-cv-script.py"
    python_version  = 3
  }
  execution_properties = [{
    max_concurrent_runs = 5
    }
  ]


  job_parameters = {
    "--TempDir"                          = "s3://${dependency.glue_s3.outputs.s3_bucket_id}/temporary/",
    "--extra-jars"                       = "s3://${dependency.glue_s3.outputs.s3_bucket_id}/aws-msk-iam-auth-1.1.1-all.jar",
    "--enable-metrics"                   = "true",
    "--spark-event-logs-path"            = "s3://aws-glue-assets-${local.aws_account_id}-${local.aws_region}/sparkHistoryLogs/",
    "--enable-job-insights"              = "true",
    "--enable-observability-metrics"     = "true",
    "--conf"                             = "spark.serializer=org.apache.spark.serializer.KryoSerializer",
    "--enable-glue-datacatalog"          = "true",
    "--enable-continuous-cloudwatch-log" = "true",
    "--job-bookmark-option"              = "job-bookmark-disable",
    "--datalake-formats"                 = "hudi",
    "--job-language"                     = "python"
  }
  cross_account_role_arn = "arn:aws:iam::123456789012:role/external-account-role"


  tags = {
    Owner               = "dev-team"
    project-name        = "connected-vehicle-platform"
    Name                = "hmcl-cv-${local.environment}-glue-jobs"
    resource-type       = "glue"
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

dependency "glue_s3" {
  config_path = "../../../s3/glue-s3"
  mock_outputs = {
    s3_bucket_id = "hmcl-cv-dev-aps1-glue-bucket"
  }
}

dependency "glue_connectors" {
  config_path = "../../glue-connectors"
  mock_outputs = {
    connections = ["conn1", "conn2"]
  }
}

dependency "glue_role" {
  config_path = "../../glue-role"
  mock_outputs = {
    glue_role_arn = "arn"
  }
}

dependency "sg" {
  config_path = "../../../sgs"
  mock_outputs = {
    all_security_group_ids = {
      glue_sg = "sg-00e550564da3539ae"
    }
  }
}

dependency "msk" {
  config_path = "../../../msk"
  mock_outputs = {
    msk_arn = "arn:aws:kafka:us-west-2:905418263290:cluster/hmcl-cv-dev-msk-cluster/765f2984-5d57-4d09-a529-ba8912d1d01e-4"
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