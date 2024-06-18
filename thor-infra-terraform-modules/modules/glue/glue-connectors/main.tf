resource "aws_glue_connection" "msk" {
  connection_type = "KAFKA"
  connection_properties = var.kafka_connection_properties
  physical_connection_requirements {
     availability_zone       = var.vpc_availability_zone
     security_group_id_list = var.vpc_security_group_id_list
     subnet_id               = var.vpc_subnet_id
  }
  name = var.msk_connection_name
}

resource "aws_glue_connection" "network" {
  connection_type = "NETWORK"
  physical_connection_requirements {
     availability_zone       = var.vpc_availability_zone
     security_group_id_list = var.vpc_security_group_id_list
     subnet_id               = var.vpc_subnet_id
  }
  name = var.network_connection_name
}