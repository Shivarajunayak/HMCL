module "sqs_queues" {

  source = "./aws-sqs"

  for_each = var.sqs_queues

  content_based_deduplication           = try(each.value.content_based_deduplication, null)
  create                                = try(each.value.create, true)
  create_dlq                            = try(each.value.create_dlq, false)
  create_dlq_queue_policy               = try(each.value.create_dlq_queue_policy, false)
  create_dlq_redrive_allow_policy       = try(each.value.create_dlq_redrive_allow_policy, true)
  create_queue_policy                   = try(each.value.create_queue_policy, false)
  deduplication_scope                   = try(each.value.deduplication_scope, null)
  delay_seconds                         = try(each.value.delay_seconds, null)
  dlq_content_based_deduplication       = try(each.value.dlq_content_based_deduplication, null)
  dlq_deduplication_scope               = try(each.value.dlq_deduplication_scope, null)
  dlq_delay_seconds                     = try(each.value.dlq_delay_seconds, null)
  dlq_kms_data_key_reuse_period_seconds = try(each.value.dlq_kms_data_key_reuse_period_seconds, null)
  dlq_kms_master_key_id                 = try(each.value.dlq_kms_master_key_id, null)
  dlq_message_retention_seconds         = try(each.value.dlq_message_retention_seconds, null)
  dlq_name                              = try(each.value.dlq_name, null)
  dlq_queue_policy_statements           = try(each.value.dlq_queue_policy_statements, {})
  dlq_receive_wait_time_seconds         = try(each.value.dlq_receive_wait_time_seconds, null)
  dlq_redrive_allow_policy              = try(each.value.dlq_redrive_allow_policy, {})
  dlq_sqs_managed_sse_enabled           = try(each.value.dlq_sqs_managed_sse_enabled, true)
  dlq_tags                              = try(each.value.dlq_tags, {})
  dlq_visibility_timeout_seconds        = try(each.value.dlq_visibility_timeout_seconds, null)
  fifo_queue                            = try(each.value.fifo_queue, false)
  fifo_throughput_limit                 = try(each.value.fifo_throughput_limit, null)
  kms_data_key_reuse_period_seconds     = try(each.value.kms_data_key_reuse_period_seconds, null)
  kms_master_key_id                     = try(each.value.kms_master_key_id, null)
  max_message_size                      = try(each.value.max_message_size, null)
  message_retention_seconds             = try(each.value.message_retention_seconds, null)
  name                                  = try(each.value.name, null)
  override_dlq_queue_policy_documents   = try(each.value.override_dlq_queue_policy_documents, [])
  override_queue_policy_documents       = try(each.value.override_queue_policy_documents, [])
  queue_policy_statements               = try(each.value.queue_policy_statements, {})
  receive_wait_time_seconds             = try(each.value.receive_wait_time_seconds, null)
  redrive_allow_policy                  = try(each.value.redrive_allow_policy, {})
  redrive_policy                        = try(each.value.redrive_policy, {})
  source_dlq_queue_policy_documents     = try(each.value.source_dlq_queue_policy_documents, [])
  source_queue_policy_documents         = try(each.value.source_queue_policy_documents, [])
  sqs_managed_sse_enabled               = try(each.value.sqs_managed_sse_enabled, true)
  tags                                  = try(each.value.tags, {})
  use_name_prefix                       = try(each.value.use_name_prefix, false)
  visibility_timeout_seconds            = try(each.value.visibility_timeout_seconds, null)

}
