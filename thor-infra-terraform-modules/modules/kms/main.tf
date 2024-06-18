module "kms" {
  source = "./aws-kms"


  description = "EC2 AutoScaling key usage"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  key_administrators                = var.key_administrators                # ["arn:aws:iam::012345678901:role/admin"]
  key_service_roles_for_autoscaling = var.key_service_roles_for_autoscaling # ["arn:aws:iam::012345678901:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
  key_users                         = var.key_users                         # ["arn:aws:iam::012345678901:role/user"]
  source_policy_documents           = var.source_policy_documents
  key_statements                    = var.key_statements


  # Aliases
  aliases                 = var.aliases #["mycompany/ebs"]
  aliases_use_name_prefix = var.aliases_use_name_prefix

  # Grants
  grants = var.grants

  # {
  #   lambda = {
  #     grantee_principal = "arn:aws:iam::012345678901:role/lambda-function"
  #     operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
  #     constraints = {
  #       encryption_context_equals = {
  #         Department = "Finance"
  #       }
  #     }
  #   }
  # }

  tags = var.tags
}


# module "kms_external" {
#   source = "./aws-kms"

#   create_external = var.create_external

#   description         = "External key example"
#   key_material_base64 = var.key_material_base64
#   valid_to            = var.valid_to  #"2085-04-12T23:20:50.52Z"

#   # Policy
#   key_administrators                 =  var.key_administrators # ["arn:aws:iam::012345678901:role/admin"]
#   key_service_roles_for_autoscaling  = var.key_service_roles_for_autoscaling # ["arn:aws:iam::012345678901:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]
#   key_users          = var.key_users # ["arn:aws:iam::012345678901:role/user"]
#    source_policy_documents           = var.source_policy_documents
#   key_statements                    = var.key_statements

#   # Aliases
#   aliases                 = var.aliases
#   aliases_use_name_prefix = var.aliases_use_name_prefix

#   # Grants
#   grants = var.grants

#   tags = var.tags
# }
