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
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/lambda"
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

  function_name          = "hmcl-cv-${local.environment}-preprovisioning-cert-gen-lambda"
  description            = "preprovisioning cert gen API Lambda"
  handler                = "index.handler"
  runtime                = "nodejs20.x"
  timeout                = 900
  memory_size            = 512
  ephemeral_storage_size = 512

  create_package = false

  s3_existing_package = {
    bucket = dependency.lambda_code_s3.outputs.s3_bucket_id
    key    = "preprovisioning-cert-gen-api/hmcl-cvp-preprovisioning-cert-gen.zip"
  }

  environment_variables = {

    SSM_PARAMETER_STORE_TIMEOUT_MILLIS           = 0
    SSM_PARAMETER_STORE_TTL                      = 0
    PARAMETERS_SECRETS_EXTENSION_CACHE_ENABLED   = "TRUE"
    PARAMETERS_SECRETS_EXTENSION_CACHE_SIZE      = 0
    PARAMETERS_SECRETS_EXTENSION_HTTP_PORT       = 2773
    PARAMETERS_SECRETS_EXTENSION_MAX_CONNECTIONS = 3
    PARAMETERS_SECRETS_EXTENSION_LOG_LEVEL       = "INFO"
    SECRETS_MANAGER_TTL                          = 0
    SECRETS_MANAGER_TIMEOUT_MILLIS               = 0
    INTERMEDIATE_CA_PARAMETER_NAME               = "hmcl-cv-${local.environment}-iot-acmpca-intermediate-ca"
    IOT_POLICY_NAME                              = "hmcl-cv-${local.environment}-preprovisioning-cert-iot-policy"
    VALIDITY                                     = 1
    VALIDITY_TYPE                                = "YEARS"
    REGION                                       = "${local.aws_region}"
    SECRET_NAME                                  = "hmcl-cv-${local.environment}-claim-certificate"
  }

  layers = [
    "arn:aws:lambda:us-west-2:345057560386:layer:AWS-Parameters-and-Secrets-Lambda-Extension:11",
    "arn:aws:lambda:us-west-2:580247275435:layer:LambdaInsightsExtension:52",
    "arn:aws:lambda:us-west-2:905418263290:layer:hmcl-cv-node-modules:1"
  ]


  role_name                         = "hmcl-cv-${local.environment}-${local.aws_region_short}-preprovisioning-cert-gen-role"
  role_force_detach_policies        = true
  attach_network_policy             = true
  attach_tracing_policy             = true
  attach_async_event_policy         = false
  attach_cloudwatch_logs_policy     = true
  cloudwatch_logs_retention_in_days = 1
  cloudwatch_logs_kms_key_id        = dependency.kms.outputs.key_arn

  attach_policies    = true
  number_of_policies = 1
  policies           = ["arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy"]

  publish = true
  allowed_triggers = {
    SecretsManager = {
      principal = "secretsmanager.amazonaws.com"
    }
  }

  attach_policy_statements = true
  policy_statements = {
    kms = {
      effect = "Allow",
      actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:CreateGrant",
        "kms:ListAliases",
        "kms:ListKeys",
        "kms:DescribeKey",
        "kms:GenerateDataKey"
      ],
      resources = [dependency.kms.outputs.key_arn]
    },
    secretsmanager = {
      effect = "Allow",
      actions = ["secretsmanager:GetSecretValue",
      "secretsmanager:PutSecretValue"],
      resources = ["*"]
    },
    parameterstore = {
      effect = "Allow",
      actions = ["ssm:GetParameter",
        "ssm:PutParameter",
        "ssm:AddTagsToResource"
      ],
      resources = ["*"]
    },
    iot = {
      effect = "Allow",
      actions = [
        "iot:RegisterCertificate",
        "iot:AttachPolicy",
        "iot:DescribeEndpoint"
      ],
      resources = ["*"]
    },
    acm_pca = {
      effect = "Allow",
      actions = [
        "acm-pca:IssueCertificate",
        "acm-pca:GetCertificate"
      ],
      resources = ["*"]
    },


  }





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



dependency "lambda_code_s3" {
  config_path = "../../s3/lambda-code-s3"
  mock_outputs = {
    s3_bucket_id = "hmcl-cv-dev-aps1-lambda-code-bucket"
  }
}

dependency "kms" {
  config_path = "../../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}

dependency "secretsmanager" {
  config_path = "../../secretsmanager"

  mock_outputs = {
    all_secret_ids = {

      claim_certificate_secret = "hmcl-cv-dev-claim-certificate"

    }
  }
}