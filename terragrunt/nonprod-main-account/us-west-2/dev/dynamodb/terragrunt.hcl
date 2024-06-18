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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/dynamodb"
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

  dynamodb_table = {

    command-table = {

      table_name     = "hmcl_cv_${local.environment}_command"
      billing_mode   = "PROVISIONED"
      read_capacity  = 1
      write_capacity = 1
      hash_key       = "uuid"
      attribute = [
        {
          name = "uuid"
          type = "S"
        },
        {
          name = "commandRefId"
          type = "S"
        },
        {
          name = "vid"
          type = "S"
        }
      ]
      global_secondary_indexes = [
        {
          index_name               = "commandRefId-index"
          index_hash_key           = "commandRefId"
          index_read_capacity      = 1
          index_write_capacity     = 1
          index_projection_type    = "ALL"
          index_non_key_attributes = []
        },
        {
          index_name               = "vid-index"
          index_hash_key           = "vid"
          index_read_capacity      = 1
          index_write_capacity     = 1
          index_projection_type    = "ALL"
          index_non_key_attributes = []
        }
      ]
      deletion_protection_enabled = false
      server_side_encryption = [
        {
          server_side_encryption_enabled     = true
          server_side_encryption_kms_key_arn = dependency.kms.outputs.key_arn
        }
      ]
      ttl = [
        {
          ttl_enabled        = false
          ttl_attribute_name = ""
        }
      ]
      stream_enabled   = false
      stream_view_type = "NEW_AND_OLD_IMAGES"
    },

    customer-preference-table = {

      table_name     = "hmcl_cv_${local.environment}_customer_preference"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 5
      hash_key       = "vid"
      range_key      = "profileId"
      attribute = [
        {
          name = "vid"
          type = "S"
        },
        {
          name = "profileId"
          type = "S"
        }
      ]
      global_secondary_indexes    = []
      deletion_protection_enabled = false
      server_side_encryption = [
        {
          server_side_encryption_enabled     = true
          server_side_encryption_kms_key_arn = dependency.kms.outputs.key_arn
        }
      ]
      ttl = [
        {
          ttl_enabled        = false
          ttl_attribute_name = ""
        }
      ]

      stream_enabled   = false
      stream_view_type = "NEW_AND_OLD_IMAGES"
    },

    device-ledger-table = {

      table_name     = "hmcl_cv_${local.environment}_device_ledger"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 5
      hash_key       = "VIRTUAL_ID"
      attribute = [
        {
          name = "VIN"
          type = "S"
        },
        {
          name = "TCU_ID"
          type = "S"
        },
        {
          name = "VIRTUAL_ID"
          type = "S"
        }
      ]
      global_secondary_indexes = [{
        index_name               = "TCU_ID"
        index_hash_key           = "TCU_ID"
        index_read_capacity      = 5
        index_write_capacity     = 5
        index_projection_type    = "ALL"
        index_non_key_attributes = []
        },
        {
          index_name               = "VIN"
          index_hash_key           = "VIN"
          index_read_capacity      = 5
          index_write_capacity     = 5
          index_projection_type    = "ALL"
          index_non_key_attributes = []
      }]
      deletion_protection_enabled = false
      server_side_encryption = [
        {
          server_side_encryption_enabled     = true
          server_side_encryption_kms_key_arn = dependency.kms.outputs.key_arn
        }
      ]
      ttl = [
        {
          ttl_enabled        = false
          ttl_attribute_name = ""
        }
      ]
      stream_enabled   = false
      stream_view_type = "NEW_AND_OLD_IMAGES"
    },

    tcu-table = {

      table_name     = "hmcl_cv_${local.environment}_tcu"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 5
      hash_key       = "TCU_ID"
      attribute = [
        {
          name = "TCU_ID"
          type = "S"
        }
      ]
      global_secondary_indexes    = []
      deletion_protection_enabled = false
      server_side_encryption = [
        {
          server_side_encryption_enabled     = true
          server_side_encryption_kms_key_arn = dependency.kms.outputs.key_arn
        }
      ]
      ttl = [
        {
          ttl_enabled        = false
          ttl_attribute_name = ""
        }
      ]
      stream_enabled   = false
      stream_view_type = "NEW_AND_OLD_IMAGES"
    },

    notification-table = {

      table_name     = "hmcl_cv_${local.environment}_notification"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 5
      hash_key       = "VehicleVid"
      range_key      = "NotificationGenTsp"
      attribute = [
        {
          name = "VehicleVid"
          type = "S"
        },
        {
          name = "NotificationGenTsp"
          type = "S"
        }
      ]
      global_secondary_indexes    = []
      deletion_protection_enabled = false
      server_side_encryption = [
        {
          server_side_encryption_enabled     = true
          server_side_encryption_kms_key_arn = dependency.kms.outputs.key_arn
        }
      ]
      ttl = [
        {
          ttl_enabled        = false
          ttl_attribute_name = ""
        }
      ]
      stream_enabled   = false
      stream_view_type = "NEW_AND_OLD_IMAGES"
    },
  }


  enable_dax                     = false
  name                           = "hmcl-cv-${local.environment}-dax-cluster"
  subnet_ids                     = ["subnet-05ae36ea89ae4ccc9", "subnet-0b407da0a83ecee01"]
  dax_parameter_group_query_ttl  = "300000"
  dax_parameter_group_record_ttl = "300000"
  iam_role_arn                   = "arn:aws:iam::${local.aws_account_id}:role/aws-service-role/dax.amazonaws.com/AWSServiceRoleForDAX"
  node_type                      = "dax.r4.large"
  node_count                     = 1
  maintenance_window             = "sun:00:00-sun:01:00"
  security_group_ids             = [dependency.sg.outputs.all_security_group_ids.dax_sg]
  server_side_encryption         = true



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



dependency "sg" {
  config_path = "../sgs"
  mock_outputs = {

    all_security_group_ids = {

      "dax_sg" = "sg-00e550564da3539ae"

    }
  }
}

dependency "kms" {
  config_path = "../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}