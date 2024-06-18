variable "campaign_json" {
  type        = string
  description = "JSON string for the campaign configuration."
  default     = null
}
variable "campaign_name" {
  type        = string
  description = "The name of the campaign."
  default     = null
}
variable "signal_catalog_arn" {
  type        = string
  description = "The ARN of the signal catalog."
  default     = null
}
variable "target_arn" {
  type        = string
  description = "The ARN of the target associated with the campaign."
  default     = null
}
variable "terraform_role_arn" {
  description = "Role ARN for assuming a role in the target account"
  type        = string
  default     = ""
}
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
}
variable "fleetwise_endpoint_url" {
  description = "Endpoint URL for IoT FleetWise"
  type        = string
  default     = ""
}


