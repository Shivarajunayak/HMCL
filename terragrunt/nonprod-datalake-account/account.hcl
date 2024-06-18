# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
    account_name = "CVP-HMCL-nonprod-datalake"
    aws_account_id = "637423615990"
    aws_profile = ""
    deployment_role = "hmcl-terraform-assume-role"
}
