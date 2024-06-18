output "iam_role_arn" {
  value       = module.iam_assume_role.iam_role_arn
  description = "IAM Role arn"
}
