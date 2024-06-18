output "cognito_user_pool_arn" {
  description = "ARN of the AWS Cognito User Pool"
  value       = module.aws_cognito_user_pool_complete.arn
}
output "cognito_user_pool_id" {
  description = "ID of the AWS Cognito User Pool"
  value       = module.aws_cognito_user_pool_complete.id
}
output "cognito_user_pool_endpoint" {
  description = "Endpoint of the AWS Cognito User Pool"
  value       = module.aws_cognito_user_pool_complete.endpoint
}
