# Set common variables for the region. This is automatically pulled in in the root terragrunt.hcl configuration to
# configure the remote state bucket and pass forward to the child modules as inputs.
locals {
  aws_region = "us-west-2"
  aws_region_short = "usw2"
  sso_region = "ap-south-1"
}