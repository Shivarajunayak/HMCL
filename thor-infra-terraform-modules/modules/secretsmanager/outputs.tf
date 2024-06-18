output "all_secret_arns" {
  description = "Secret arns map"
  value       = module.secrets_manager.secret_arns
}


output "all_secret_ids" {
  description = "Secret ids map"
  value       = module.secrets_manager.secret_ids
}
