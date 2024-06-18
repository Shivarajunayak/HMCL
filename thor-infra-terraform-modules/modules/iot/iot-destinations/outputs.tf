output "iam_role_arn" {
  description = "The ARN of the IAM role created for the IoT Topic Rule Destination."
  value       = aws_iam_role.example.arn
}
output "custom_policy_arn" {
  description = "The ARN of the custom IAM policy attached to the IAM role."
  value       = aws_iam_policy.custom_policy.arn
}
output "iot_topic_rule_destination_arn" {
  description = "The ARN of the IoT Topic Rule Destination."
  value       = aws_iot_topic_rule_destination.example.arn
}
output "iot_topic_rule_destination_id" {
  description = "The ID of the IoT Topic Rule Destination."
  value       = aws_iot_topic_rule_destination.example.id
}
