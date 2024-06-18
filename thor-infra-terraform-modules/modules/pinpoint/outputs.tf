output "all_application_ids" {
  description = "pinpoint app ids Map"
  value       = try({ for key, pinpoint_notification in module.pinpoint_notifications : key => pinpoint_notification.application_id }, {})
}

output "all_application_arns" {
  description = "pinpoint app arns Map"
  value       = try({ for key, pinpoint_notification in module.pinpoint_notifications : key => pinpoint_notification.application_arn }, {})
}
