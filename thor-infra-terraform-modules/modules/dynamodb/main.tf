resource "aws_dynamodb_table" "dynamodb_table" {
  for_each                    = { for key, value in var.dynamodb_table : value.table_name => value }
  name                        = try(each.value.table_name, null)
  billing_mode                = try(each.value.billing_mode, null)
  read_capacity               = lookup(each.value, "read_capacity", null)
  write_capacity              = lookup(each.value, "write_capacity", null)
  hash_key                    = try(each.value.hash_key, null)
  range_key                   = lookup(each.value, "range_key", null)
  deletion_protection_enabled = try(each.value.deletion_protection_enabled, false)
  stream_enabled              = try(each.value.stream_enabled, false)
  stream_view_type            = each.value.stream_enabled ? each.value.stream_view_type : null

  dynamic "server_side_encryption" {
    for_each = { for key, value in each.value.server_side_encryption : key => value }
    content {
      enabled     = server_side_encryption.value.server_side_encryption_enabled
      kms_key_arn = server_side_encryption.value.server_side_encryption_kms_key_arn
    }
  }

  dynamic "ttl" {
    for_each = { for key, value in each.value.ttl : key => value }
    content {
      enabled        = ttl.value.ttl_enabled
      attribute_name = ttl.value.ttl_attribute_name
    }
  }

  dynamic "attribute" {
    for_each = { for key, value in each.value.attribute : key => value }
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = { for key, value in each.value.global_secondary_indexes : key => value }
    content {
      name               = try(global_secondary_index.value.index_name, "")
      hash_key           = try(global_secondary_index.value.index_hash_key, "")
      projection_type    = try(global_secondary_index.value.index_projection_type, "")
      range_key          = lookup(global_secondary_index.value, "index_range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "index_read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "index_write_capacity", null)
      non_key_attributes = lookup(global_secondary_index.value, "index_non_key_attributes", null)
    }
  }


  tags = merge(
    var.tags,
    {
      Name = each.value.table_name
  })
}


resource "aws_dax_subnet_group" "subnet_group" {
  name       = try(var.name, "dax-subnet-group")
  subnet_ids = try(var.subnet_ids, [])
}

resource "aws_dax_parameter_group" "parameter_group" {
  name = try(var.name, "dax-parameter-group")

  parameters {
    name  = "query-ttl-millis"
    value = var.dax_parameter_group_query_ttl
  }

  parameters {
    name  = "record-ttl-millis"
    value = var.dax_parameter_group_record_ttl
  }
}


resource "aws_dax_cluster" "cluster" {

  count = var.enable_dax ? 1 : 0

  cluster_name       = try(var.name, "dax-cluster")
  iam_role_arn       = try(var.iam_role_arn, null)
  node_type          = try(var.node_type, null)
  replication_factor = try(var.node_count, null)
  server_side_encryption {
    enabled = try(var.server_side_encryption, true)
  }
  parameter_group_name = aws_dax_parameter_group.parameter_group.name
  subnet_group_name    = aws_dax_subnet_group.subnet_group.name
  maintenance_window   = try(var.maintenance_window, null)
  security_group_ids   = try(var.security_group_ids, null)
  tags                 = var.tags
}
