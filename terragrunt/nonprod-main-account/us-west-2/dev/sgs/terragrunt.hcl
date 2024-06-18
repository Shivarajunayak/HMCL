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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/sg"
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

  security_groups = {

    msk_sg = {

      name        = "hmcl-cv-${local.environment}-msk-sg"
      description = "Security Group for MSK Cluster"
      vpc_id      = "vpc-00038ad12d3dd001f"
      ingress_rules = {
        plaintext = {
          description = "Plaintext"
          from_port   = 9092
          to_port     = 9092
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        sasl_scram = {
          description = "sasl_scram"
          from_port   = 9096
          to_port     = 9096
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        iam = {
          description = "iam"
          from_port   = 9098
          to_port     = 9098
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        }
      }
      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-msk-sg"
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
    },

    dax_sg = {

      name        = "hmcl-cv-${local.environment}-dax-sg"
      description = "Security Group for DAX Cluster"
      vpc_id      = "vpc-0816899ffeac2813d"
      ingress_rules = {
        dax = {
          description = "DAX"
          from_port   = 8111
          to_port     = 9111
          protocol    = "6"
          cidr_blocks = ["10.62.128.0/19"]
        }
      }
      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-dax-sg"
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

    },

    redis_sg = {

      name        = "hmcl-cv-${local.environment}-redis-sg"
      description = "Security Group for Elasticache Redis Cluster"
      vpc_id      = "vpc-0816899ffeac2813d"
      ingress_rules = {
        redis = {
          description = "redis"
          from_port   = 6379
          to_port     = 6379
          protocol    = "6"
          cidr_blocks = ["10.62.128.0/19"]
        }
      }

      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-redis-sg"
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
    },

    destinations_sg = {

      name        = "hmcl-cv-${local.environment}-destinations-sg"
      description = "Security Group for destinations for iot"
      vpc_id      = "vpc-00038ad12d3dd001f"
      ingress_rules = {
        plaintext = {
          description = "Plaintext"
          from_port   = 9092
          to_port     = 9092
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        sasl_scram = {
          description = "sasl_scram"
          from_port   = 9096
          to_port     = 9096
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        iam = {
          description = "iam"
          from_port   = 9098
          to_port     = 9098
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        }
      }
      tags = {
        Owner               = "dev-team"
        project-name        = "connected-vehicle-platform"
        Name                = "hmcl-cv-${local.environment}-destinations-sg"
        resource-type       = "destinations-sg"
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
    },

    rds_sg = {
      name        = "hmcl-cv-${local.environment}-rds-sg"
      description = "Security Group for RDS Aurora PostgreSQL Cluster"
      vpc_id      = "vpc-0816899ffeac2813d"
      ingress_rules = {
        postgresql = {
          description = "PostgreSQL"
          from_port   = 5432
          to_port     = 5432
          protocol    = "6"
          cidr_blocks = ["10.20.0.0/20"]
        }
      }

      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-rds-sg"
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

    },


    flink_sg = {

      name        = "hmcl-cv-${local.environment}-flink-sg"
      description = "Security Group for Flink"
      vpc_id      = "vpc-00038ad12d3dd001f"
      ingress_rules = {
        plaintext = {
          description = "Plaintext"
          from_port   = 9092
          to_port     = 9092
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        sasl_scram = {
          description = "sasl_scram"
          from_port   = 9096
          to_port     = 9096
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        iam = {
          description = "iam"
          from_port   = 9098
          to_port     = 9098
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        }
      }
      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-flink-sg"
        resource-type  = "flink-sg"
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
    },

    glue_sg = {

      name        = "hmcl-cv-${local.environment}-glue-sg"
      description = "Security Group for Glue"
      vpc_id      = "vpc-00038ad12d3dd001f"
      ingress_rules = {
        plaintext = {
          description = "Plaintext"
          from_port   = 9092
          to_port     = 9092
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        sasl_scram = {
          description = "sasl_scram"
          from_port   = 9096
          to_port     = 9096
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        iam = {
          description = "iam"
          from_port   = 9098
          to_port     = 9098
          protocol    = "6"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        },
        All = {
          description = "All"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["10.62.24.0/21", "10.62.128.0/19"]
        }
      }
      tags = {
        Owner          = "dev-team"
        project-name   = "connected-vehicle-platform"
        Name           = "hmcl-cv-${local.environment}-glue-sg"
        resource-type  = "flink-sg"
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

  }

}