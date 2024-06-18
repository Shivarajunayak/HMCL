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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/glue/glue-role?ref=feature_glue"
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

  iam_role_name          = "hmcl-cv-${local.environment}-${local.aws_region_short}-glue-role"
  iam_role_description   = "IAM role for AWS Glue ETL job"
  attach_policy_arns     = ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"]
  iam_policy_name        = "hmcl-cv-${local.environment}-${local.aws_region_short}-glue-policy"
  iam_policy_description = "Custom policy for Glue role"

  custom_policy_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "BaseAppPermissions",
        Effect = "Allow",
        Action = [
          "glue:*",
          "redshift:DescribeClusters",
          "redshift:DescribeClusterSubnetGroups",
          "iam:ListRoles",
          "iam:ListUsers",
          "iam:ListGroups",
          "iam:ListRolePolicies",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:ListAttachedRolePolicies",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeRouteTables",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters",
          "rds:DescribeDBSubnetGroups",
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation",
          "cloudformation:ListStacks",
          "cloudformation:DescribeStacks",
          "cloudformation:GetTemplateSummary",
          "dynamodb:ListTables",
          "kms:ListAliases",
          "kms:DescribeKey",
          "cloudwatch:GetMetricData",
          "cloudwatch:ListDashboards",
          "databrew:ListRecipes",
          "databrew:ListRecipeVersions",
          "databrew:DescribeRecipe"
        ],
        Resource = "*"
      },
      {
        Sid    = "S3",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::aws-glue-*/*",
          "arn:aws:s3:::*/*aws-glue-*/*",
          "arn:aws:s3:::aws-glue-*"
        ]
      },
      {
        Effect   = "Allow",
        Action   = "tag:GetResources",
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:CreateBucket",
        Resource = "arn:aws:s3:::aws-glue-*"
      },
      {
        Effect   = "Allow",
        Action   = "logs:GetLogEvents",
        Resource = "arn:aws:logs:*:*:/aws-glue/*"
      },
      {
        Effect = "Allow",
        Action = [
          "cloudformation:CreateStack",
          "cloudformation:DeleteStack"
        ],
        Resource = "arn:aws:cloudformation:*:*:stack/aws-glue*/*"
      },
      {
        Effect = "Allow",
        Action = "ec2:RunInstances",
        Resource = [
          "arn:aws:ec2:*:*:instance/*",
          "arn:aws:ec2:*:*:key-pair/*",
          "arn:aws:ec2:*:*:image/*",
          "arn:aws:ec2:*:*:security-group/*",
          "arn:aws:ec2:*:*:network-interface/*",
          "arn:aws:ec2:*:*:subnet/*",
          "arn:aws:ec2:*:*:volume/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:TerminateInstances",
          "ec2:CreateTags",
          "ec2:DeleteTags"
        ],
        Resource = "arn:aws:ec2:*:*:instance/*",
        Condition = {
          "StringLike" : {
            "ec2:ResourceTag/aws:cloudformation:stack-id" : "arn:aws:cloudformation:*:*:stack/aws-glue-*/*"
          },
          "StringEquals" : {
            "ec2:ResourceTag/aws:cloudformation:logical-id" : "ZeppelinInstance"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:PassRole",
        Resource = "arn:aws:iam::*:role/AWSGlueServiceRole*",
        Condition = {
          "StringLike" : {
            "iam:PassedToService" : "glue.amazonaws.com"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:PassRole",
        Resource = "arn:aws:iam::*:role/AWSGlueServiceNotebookRole*",
        Condition = {
          "StringLike" : {
            "iam:PassedToService" : "ec2.amazonaws.com"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "iam:PassRole",
        Resource = "arn:aws:iam::*:role/service-role/AWSGlueServiceRole*",
        Condition = {
          "StringLike" : {
            "iam:PassedToService" : "glue.amazonaws.com"
          }
        }
      },

      {
        "Sid" : "AllowCreateResourceShare",
        "Effect" : "Allow",
        "Action" : [
          "ram:CreateResourceShare"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLikeIfExists" : {
            "ram:RequestedResourceType" : [
              "glue:Table",
              "glue:Database",
              "glue:Catalog"
            ]
          }
        }
      },
      {
        "Sid" : "AllowManageResourceShare",
        "Effect" : "Allow",
        "Action" : [
          "ram:UpdateResourceShare",
          "ram:DeleteResourceShare",
          "ram:AssociateResourceShare",
          "ram:DisassociateResourceShare",
          "ram:GetResourceShares"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ram:ResourceShareName" : [
              "LakeFormation*"
            ]
          }
        }
      },
      {
        "Sid" : "AllowManageResourceSharePermissions",
        "Effect" : "Allow",
        "Action" : [
          "ram:AssociateResourceSharePermission"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ram:PermissionArn" : [
              "arn:aws:ram::aws:permission/AWSRAMLFEnabled*"
            ]
          }
        }
      },
      {
        "Sid" : "AllowXAcctManagerPermissions",
        "Effect" : "Allow",
        "Action" : [
          "glue:PutResourcePolicy",
          "glue:DeleteResourcePolicy",
          "organizations:DescribeOrganization",
          "organizations:DescribeAccount",
          "ram:Get*",
          "ram:List*"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowOrganizationsPermissions",
        "Effect" : "Allow",
        "Action" : [
          "organizations:ListRoots",
          "organizations:ListAccountsForParent",
          "organizations:ListOrganizationalUnitsForParent"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "KMS",
        "Effect" : "Allow",
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey",
          "kms:CreateGrant",
          "kms:List*",
          "kms:Get*",
          "kms:RevokeGrant",
          "kms:Describe*"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "PassRole",
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : "*"
      },
      {
        "Sid" : "Secrets",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka:*"
        ],
        "Resource" : [
          "*",
          dependency.msk.outputs.msk_arn
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:*"
        ],
        "Resource" : [
          "*",
          dependency.msk.outputs.msk_arn,
          "${dependency.msk.outputs.msk_arn}/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::hmcl-cv-${local.environment}-${local.aws_region}-raw",
          "arn:aws:s3:::hmcl-cv-${local.environment}-${local.aws_region}-raw/*",
          "${dependency.glue_s3.outputs.s3_bucket_arn}",
          "${dependency.glue_s3.outputs.s3_bucket_arn}/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "glue:GetDatabase"
        ],
        "Resource" : [
          "arn:aws:glue:${local.aws_region}:637423615990:catalog",
          "arn:aws:glue:${local.aws_region}:637423615990:database/default"
        ]
      }
    ]
  })


  tags = {
    Owner               = "dev-team"
    project-name        = "connected-vehicle-platform"
    Name                = "hmcl-cv-${local.environment}-glue"
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
  config_path = "../../s3/glue-s3"
  mock_outputs = {
    s3_bucket_arn = "arn"
  }
}


dependency "msk" {
  config_path = "../../msk"
  mock_outputs = {
    msk_arn = "arn:aws:kafka:us-west-2:905418263290:cluster/hmcl-cv-dev-msk-cluster/765f2984-5d57-4d09-a529-ba8912d1d01e-4"
  }
}

dependency "secretsmanager" {
  config_path = "../../secretsmanager"

  mock_outputs = {
    all_secret_arns = {

      msk_secret  = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
      test_secret = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"

    }
  }
}