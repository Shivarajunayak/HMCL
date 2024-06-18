output "iot_policy_arns" {

  description = "ARNs of IOT Policies"
  value       = { for k, v in aws_iot_policy.iot_policies : k => v.arn }

}

output "iot_policy_names" {

  description = "Names of IOT Policies"
  value       = { for k, v in aws_iot_policy.iot_policies : k => v.name }

}
