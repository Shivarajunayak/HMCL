data "aws_region" "current" {}

locals {
  policy = jsonencode(
    {
      Version : "2012-10-17"
      Statement : [
        for k, v in var.policy : {
          Sid : try(v.sid, "")
          Action : v.allowed_actions
          Effect : try(v.effect, "Allow")
          Resource : v.resources
        }
      ]
    }
  )
}

module "iam_eks_role" {
  source    = "../../../iam/aws-iam/iam-role-for-service-accounts-eks" #terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-${var.role_name}-irsa"

  role_policy_arns = {
    policy = module.iam_policy.arn
  }
  role_path = var.role_policy_path

  oidc_providers = {
    one = {
      provider_arn               = var.eks_oidc_provider_arn
      namespace_service_accounts = ["*:${var.role_name}*"]
    }
  }
  assume_role_condition_test = "StringLike"
}

module "iam_policy" {
  source = "../../../iam/aws-iam/iam-policy" # terraform-aws-modules/iam/aws//modules/iam-policy"
  name   = "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-${var.role_name}-policy"
  path   = var.role_policy_path

  policy = local.policy
}
