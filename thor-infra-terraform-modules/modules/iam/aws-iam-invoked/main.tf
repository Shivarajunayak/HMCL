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

################################################################################
# IAM
################################################################################


module "iam_assume_role" {

  source = "../aws-iam/iam-assumable-role"

  create_role             = try(var.create_role, false)
  create_instance_profile = try(var.create_instance_profile, false)
  trusted_role_arns       = try(var.trusted_role_arns, [])
  trusted_role_services   = try(var.trusted_role_services, [])

  role_name         = "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-${var.role_name}-role"
  role_requires_mfa = false

  role_path = var.role_policy_path

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]
}

module "iam_policy" {
  source = "../aws-iam/iam-policy" # terraform-aws-modules/iam/aws//modules/iam-policy"
  name   = "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-${var.role_name}-policy"
  path   = var.role_policy_path

  policy = local.policy
}
