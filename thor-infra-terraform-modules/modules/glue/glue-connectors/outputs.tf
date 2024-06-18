output "connections" {

    description = "connection names"
    value =  tolist([aws_glue_connection.msk.name, aws_glue_connection.network.name])
  
}
