variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
variable "signal_catalog_arn" {
  description = "ARN of the Signal Catalog"
  type        = string
  default     = ""
}
variable "lks_template_name" {
  description = "Name of the LKS Template"
  type        = string
  default     = "fwdemo-lks-template"
}
variable "state_template_properties" {
  description = "Properties for the state template"
  type        = list(string)
  default     = ["Vehicle.ABS.DemoBrakePedalPressure", "Vehicle.ECM.DemoEngineTorque"]
}
variable "fleetwise_endpoint_url" {
  description = "Endpoint URL for IoT FleetWise"
  type        = string
  default     = "https://controlplane.ea.us-east-1.gamma.kaleidoscope.iot.aws.dev"
}
variable "terraform_role_arn" {
  description = "Role ARN for assuming a role in the target account"
  type        = string
  default     = ""
}
