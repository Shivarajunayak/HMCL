
output "dynamodb_table_name" {
  description = "name of the created DynamoDB tables"
  value       = try({ for key, table in aws_dynamodb_table.dynamodb_table : key => table.name }, {})
}
output "dynamodb_table_arn" {
  description = "arn of the created DynamoDB tables"
  value       = try({ for key, table in aws_dynamodb_table.dynamodb_table : key => table.arn }, {})
}

output "dynamodb_table_stream_arn" {
  description = "Stream arn of the created DynamoDB tables"
  value       = try({ for key, table in aws_dynamodb_table.dynamodb_table : key => table.stream_arn }, {})
}

output "configuration_endpoint" {
  value       = try(aws_dax_cluster.cluster[0].configuration_endpoint, null)
  description = "Configuration endpoint for this DAX cluster, consisting of a DNS name and a port number"
}


output "cluster_address" {
  value       = try(aws_dax_cluster.cluster[0].cluster_address, null)
  description = "DNS name of the DAX cluster without the port appended"
}
