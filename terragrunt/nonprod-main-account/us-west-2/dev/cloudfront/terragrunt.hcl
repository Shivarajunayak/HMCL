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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/cloudfront"
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
  aliases                       = ["example1.com", "example2.com"]
  comment                       = "hmcl-cv-${local.environment}-cloudfront"
  enabled                       = true
  is_ipv6_enabled               = true
  price_class                   = "PriceClass_All"
  default_root_object           = "index.html"
  retain_on_delete              = false
  wait_for_deployment           = false
  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }
  logging_config = {
    bucket          = dependency.cloudfront_s3.outputs.s3_bucket_bucket_domain_name
    include_cookies = false
    prefix          = "cloudfront-logs/"
  }
  origin = {
    something = {
      domain_name = "something.example.com"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
    s3_one = {
      domain_name = dependency.cloudfront_s3.outputs.s3_bucket_bucket_domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }
  default_cache_behavior = {
    target_origin_id       = "something"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true
  }
  ordered_cache_behavior = [
    {
      path_pattern           = "/static/*"
      target_origin_id       = "s3_one"
      viewer_protocol_policy = "redirect-to-https"
      allowed_methods        = ["GET", "HEAD", "OPTIONS"]
      cached_methods         = ["GET", "HEAD"]
      compress               = true
      query_string           = true
    }
  ]
  //  viewer_certificate = {
  //    acm_certificate_arn = "arn:aws:acm:us-east-1:637423293078:certificate/f565ad1b-978c-4b9d-ba4b-7986e02c8f7b"
  //    ssl_support_method  = "sni-only"
  //  }

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

dependency "cloudfront_s3" {
  config_path = "../s3/cloudfront-s3"
  mock_outputs = {
    s3_bucket_bucket_domain_name = "hmcl-cv-dev-test-s3-bucket.s3.amazonaws.com"
  }
}

