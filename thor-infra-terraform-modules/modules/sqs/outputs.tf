output "all_sqs_queue_ids" {
  description = "SqS queue URLs Map"
  value       = try({ for key, sqs_queue in module.sqs_queues : key => sqs_queue.queue_id }, {})
}

output "all_sqs_queue_arns" {
  description = "SqS queue arns Map"
  value       = try({ for key, sqs_queue in module.sqs_queues : key => sqs_queue.queue_arn }, {})
}

output "all_dead_letter_queue_ids" {
  description = "DLQ SqS queue URLs Map"
  value       = try({ for key, sqs_queue in module.sqs_queues : key => sqs_queue.dead_letter_queue_id }, {})
}

output "all_dead_letter_queue_arns" {
  description = "DLQ SqS queue arns Map"
  value       = try({ for key, sqs_queue in module.sqs_queues : key => sqs_queue.dead_letter_queue_arn }, {})
}
