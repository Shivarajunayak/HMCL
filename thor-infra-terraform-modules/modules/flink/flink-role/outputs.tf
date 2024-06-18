output "flink_role_arn" {

    description = "Flink role arn"
    value =  aws_iam_role.flink_role.arn
  
}