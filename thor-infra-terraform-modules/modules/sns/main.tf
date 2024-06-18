module "sns_topics" {

  source   = "./aws-sns"
  for_each = var.sns_topics

  #general
  create = try(each.value.create, false)
  tags   = try(each.value.tags, {})
  # Topic
  name                        = try(each.value.name, null)
  use_name_prefix             = try(each.value.use_name_prefix, false)
  application_feedback        = try(each.value.application_feedback, {})
  content_based_deduplication = try(each.value.content_based_deduplication, false)
  delivery_policy             = try(each.value.delivery_policy, null)
  display_name                = try(each.value.display_name, null)
  fifo_topic                  = try(each.value.fifo_topic, false)
  firehose_feedback           = try(each.value.firehose_feedback, {})
  http_feedback               = try(each.value.http_feedback, {})
  kms_master_key_id           = try(each.value.kms_master_key_id, null)
  lambda_feedback             = try(each.value.lambda_feedback, {})
  topic_policy                = try(each.value.topic_policy, null)
  sqs_feedback                = try(each.value.sqs_feedback, {})
  signature_version           = try(each.value.signature_version, null)
  tracing_config              = try(each.value.tracing_config, null)
  archive_policy              = try(each.value.archive_policy, null)
  # Topic Policy
  create_topic_policy             = try(each.value.create_topic_policy, false)
  source_topic_policy_documents   = try(each.value.source_topic_policy_documents, [])
  override_topic_policy_documents = try(each.value.override_topic_policy_documents, [])
  enable_default_topic_policy     = try(each.value.enable_default_topic_policy, true)
  topic_policy_statements         = try(each.value.topic_policy_statements, {})
  # Subscriptions
  create_subscription = try(each.value.create_subscription, false)
  subscriptions       = try(each.value.subscriptions, {})
  # Data Protection Policy
  data_protection_policy = try(each.value.data_protection_policy, null)


}
