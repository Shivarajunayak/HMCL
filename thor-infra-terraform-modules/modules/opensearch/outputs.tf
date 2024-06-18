################################################################################
# Domain
################################################################################

output "domain_endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = try(module.opensearch.domain_endpoint, null)
}

output "domain_arn" {
  description = "The Amazon Resource Name (ARN) of the domain"
  value       = try(module.opensearch.domain_arn, null)
}

output "domain_id" {
  description = "The unique identifier for the domain"
  value       = try(module.opensearch.domain_id, null)
}

output "domain_dashboard_endpoint" {
  description = "Domain-specific endpoint for Dashboard without https scheme"
  value       = try(module.opensearch.domain_dashboard_endpoint, null)
}