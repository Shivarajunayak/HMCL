resource "aws_s3_bucket" "example" {
  bucket = var.bucket
}

resource "aws_athena_database" "example" {
  name = var.athena_db_name
  bucket = var.bucket
  encryption_configuration {
    encryption_option = "SSE_KMS"
    kms_key           = var.kms_key_arn
  }
  force_destroy = var.force_destroy
}
 
resource "aws_athena_workgroup" "example" {
  name = var.workgroup_name
  configuration {
    enforce_workgroup_configuration    = var.enforce_workgroup_config
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics
    result_configuration {
      output_location = var.output_location
      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = var.kms_key_arn
      }
    }
  }
}
 
resource "aws_glue_catalog_table" "example" {
  name          = var.table_name
  database_name = aws_athena_database.example.name
  table_type    = var.table_type
  parameters = {
    "skip.header.line.count" = var.skip_header_line_count
  }
  storage_descriptor {
    location      = var.output_location
    input_format  = var.input_format
    output_format = var.output_format
    ser_de_info {
      name                  = var.serde_name
      serialization_library = var.serialization_library
      parameters = {
        "serialization.format" = var.serialization_format
      }
    }
    dynamic "columns" {
      for_each = var.columns
      content {
        name = columns.value.name
        type = columns.value.type
      }
    }
  }
}
 
resource "aws_athena_named_query" "example_named_query" {
  database = aws_athena_database.example.name
  query    = var.query
  name     = var.named_query_name
}
