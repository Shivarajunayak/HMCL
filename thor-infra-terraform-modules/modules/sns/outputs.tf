output "all_sns_topic_ids" {
  description = "SnS topic ids Map"
  value       = try({ for key, sns_topic in module.sns_topics : key => sns_topic.topic_id }, {})
}
