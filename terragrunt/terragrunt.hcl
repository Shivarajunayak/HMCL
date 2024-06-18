
# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform/OpenTofu that provides extra tools for working with multiple modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_region   = local.region_vars.locals.aws_region
  deployment_role = local.account_vars.locals.deployment_role

  # # Automatically load site-level variables
  # site_vars = read_terragrunt_config(find_in_parent_folders("azure.hcl"))

  # deployment_storage_resource_group_name = local.site_vars.locals.deployment_storage_resource_group_name
  # deployment_storage_account_name        = local.site_vars.locals.deployment_storage_account_name

}


# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  assume_role {
            role_arn = "arn:aws:iam::${local.account_id}:role/${local.deployment_role}"
        }

}
EOF
}


# Generate an AWSCC provider block
generate "providerawscc" {
 path      = "provider_awscc.tf"
 if_exists = "overwrite_terragrunt"
 contents  = <<EOF
  provider "awscc" {
   region = "${local.aws_region}"
   
   assume_role = {
            role_arn = "arn:aws:iam::${local.account_id}:role/${local.deployment_role}"
        }
 }
 EOF
 }

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "hmcl-cv-sharedtenant-thor-terragrunt-statefile-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}




# Configure Terragrunt to automatically store tfstate files in an Blob Storage container
# remote_state {
#   backend = "azurerm"
#   generate = {
#     path      = "backend.tf"
#     if_exists = "overwrite"
#   }
#   config = {
#     resource_group_name  = local.deployment_storage_resource_group_name
#     storage_account_name = local.deployment_storage_account_name
#     container_name       = "terraform-state"
#     key                  = "${path_relative_to_include()}/terraform.tfstate"
#   }
# }



# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)

terraform {


before_hook "tflint" {
  commands     = ["plan"]
  execute      = ["tflint"]
}
  


error_hook "import_resource" {
    commands  = ["apply"]
    execute   = ["echo", "Error Hook executed"]
    on_errors = [
      ".*",
    ]
}


  }
