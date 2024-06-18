output "kafka_destination_arns" {
  description = "kafka destination arns"
  value = [for rule in var.iot_topic_rules : rule.action.kafka.destination_arn if rule.action.kafka != null]
}