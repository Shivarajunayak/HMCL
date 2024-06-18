output "glue_role_arn" {

    description = "Glue role arn"
    value =  aws_iam_role.glue_role.arn
  
}