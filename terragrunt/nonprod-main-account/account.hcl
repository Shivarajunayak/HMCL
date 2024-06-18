# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
    account_name = "CVP-HMCL-nonprod-main"
    aws_account_id = "905418263290"
    aws_profile = ""
    deployment_role = "hmcl-terraform-assume-role"
}
