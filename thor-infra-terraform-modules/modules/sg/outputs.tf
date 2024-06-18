
output "all_security_group_ids" {
  description = "Security Group IDs Map"
  value       = { for key, security_group in module.security_groups : key => security_group.security_group_id }
}
