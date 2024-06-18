variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
}
variable "fleet_id" {
  description = "ID of the Fleet"
  type        = string
  default     = ""
}
variable "fleet_description" {
  description = "Description of the Fleet"
  type        = string
  default     = ""
}
variable "signal_catalog_arn" {
  description = "ARN of the Signal Catalog"
  type        = string
  default     = ""
}
variable "fleetwise_endpoint_url" {
  description = "Endpoint URL for IoT FleetWise"
  type        = string
  default     = ""
}
variable "terraform_role_arn" {
  description = "Role ARN for assuming a role in the target account"
  type        = string
  default     = ""
}