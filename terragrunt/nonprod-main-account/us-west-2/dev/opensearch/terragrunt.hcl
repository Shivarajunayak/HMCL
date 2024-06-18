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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/opensearch"
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
  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }
  advanced_security_options = {
    enabled                        = false
    anonymous_auth_enabled         = true
    internal_user_database_enabled = true
    master_user_options = {
      master_user_name     = "opensearch${local.environment}user"
      master_user_password = "opensearch${local.environment}password!"
    }
  }
  auto_tune_options = {
    desired_state = "ENABLED"
    maintenance_schedule = [
      {
        start_at                       = "2028-05-13T07:44:12Z"
        cron_expression_for_recurrence = "cron(0 0 ? * 1 *)"
        duration = {
          value = "2"
          unit  = "HOURS"
        }
      }
    ]
    rollback_on_disable = "NO_ROLLBACK"
  }
  cluster_config = {
    instance_count           = 4
    dedicated_master_enabled = true
    dedicated_master_type    = "c6g.large.search"
    instance_type            = "r6g.large.search"
    zone_awareness_config = {
      availability_zone_count = 2
    }
    zone_awareness_enabled = true
  }
  domain_endpoint_options = {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  domain_name = "hmcl-cv-${local.environment}-opensearch"
  ebs_options = {
    ebs_enabled = true
    iops        = 3000
    throughput  = 125
    volume_type = "gp3"
    volume_size = 20
  }
  encrypt_at_rest = {
    enabled = true
  }
  engine_version = "OpenSearch_2.11"
  log_publishing_options = [
    { log_type = "INDEX_SLOW_LOGS" },
    { log_type = "SEARCH_SLOW_LOGS" },
  ]
  node_to_node_encryption = {
    enabled = true
  }
  software_update_options = {
    auto_software_update_enabled = true
  }
  vpc_options = {
    subnet_ids = ["subnet-09ca830d19eec175d", "subnet-0b6740a481f50a6a6"]
  }
  vpc_endpoints = {
    one = {
      subnet_ids = ["subnet-09ca830d19eec175d", "subnet-0b6740a481f50a6a6"]
    }
  }
  access_policies = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "es:*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "127.0.0.1/32"
        }
      }
    }
  ]
}
EOF
  tags = {
    Owner               = "dev-team"
    project-name        = "connected-vehicle-platform"
    Name                = "hmcl-cv-${local.environment}-cloudfront"
    resource-type       = "cloudfront"
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
