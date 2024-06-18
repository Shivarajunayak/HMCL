variable "kafka_connection_properties" {
  type        = any
  description = "Kafka connection properties used for this job."
  default     = {}
}

variable "network_connection_name" {
  type        = string
  description = "Name of Network Connector"
  default     = ""
}
variable "msk_connection_name" {
  type        = string
  description = "Name of msk Connector"
  default     = ""
}
variable "vpc_availability_zone" {
  type        = string
  description = "MSK AZ"
  default     = ""
}
variable "vpc_security_group_id_list" {
  type        = list(string)
  description = "MSK SGs"
  default     = []
}
variable "vpc_subnet_id" {
  type        = string
  description = "MSK Subnet"
  default     = ""
}
