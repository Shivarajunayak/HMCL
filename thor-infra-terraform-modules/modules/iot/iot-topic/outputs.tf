output "iot_topic_rule_name" {
  description = "The name of the created IoT topic rule."
  value       = aws_iot_topic_rule.this.name
}