variable "signal_catalog_json" {
    type = string
    default = ""
    description = "Signal Catalog Json string"
}

variable "fleetwise_endpoint_url" {
    type = string
    default = ""
    description = "Fleetwise endpoint url"
}

variable "signal_catalog_name" {
    type = string
    default = ""
    description = "Fleetwise signal catalog name"
}

variable "aws_region" {
    type = string
    default = ""
    description = "Fleetwise region"
}

variable "terraform_role_arn" {
    type = string
    default = ""
    description = "Terraform role arn for spoke"
}