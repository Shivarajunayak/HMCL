output "key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = try(module.kms.key_arn, null)
}
