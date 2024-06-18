output "fleet_id" {
  description = "ID of the created fleet"
  value       = var.fleet_id
}
output "fleet_description" {
  description = "Description of the created fleet"
  value       = var.fleet_description
}
output "signal_catalog_arn" {
  description = "ARN of the signal catalog associated with the fleet"
  value       = var.signal_catalog_arn
}
output "fleet_creation_trigger" {
  description = "Trigger used for creating the fleet"
  value       = sha256(jsonencode(local.fleet_config))
}