
# Create CloudWatch Log Group for Kinesis Analytics
resource "aws_cloudwatch_log_group" "example" {
  name = var.cloudwatch_log_group
}
# Create CloudWatch Log Stream for Kinesis Analytics
resource "aws_cloudwatch_log_stream" "example" {
  name           = var.cloudwatch_log_stream
  log_group_name = aws_cloudwatch_log_group.example.name
  depends_on     = [aws_cloudwatch_log_group.example]
}
# Create Kinesis Analytics Application
resource "aws_kinesisanalyticsv2_application" "example" {
  name                   = var.application_name
  runtime_environment    = var.runtime_environment
  service_execution_role = var.flink_role_arn
  
  cloudwatch_logging_options {
       log_stream_arn = aws_cloudwatch_log_stream.example.arn
    }
  application_configuration {
    application_code_configuration {
      code_content {
        s3_content_location {
          bucket_arn     = var.bucket
          file_key       = var.s3_object_key
        }
      }
      code_content_type = "ZIPFILE"
    }
    dynamic "environment_properties" {
      for_each = var.flink_application_properties
      content {
        property_group {
          property_group_id = environment_properties.value.property_group_id
          property_map      = environment_properties.value.property_map
        }
      }
    }
    application_snapshot_configuration {
      snapshots_enabled = false
    }
    dynamic "flink_application_configuration" {
      for_each = var.flink_application_configuration
      content {
        checkpoint_configuration {
          configuration_type = flink_application_configuration.value.checkpoint_configuration_type
        }
        monitoring_configuration {
          configuration_type = flink_application_configuration.value.monitoring_configuration_type
          log_level          = flink_application_configuration.value.log_level
          metrics_level      = flink_application_configuration.value.metrics_level
        }
        parallelism_configuration {
          auto_scaling_enabled = flink_application_configuration.value.auto_scaling_enabled
          configuration_type   = flink_application_configuration.value.parallelism_configuration_type
          parallelism          = flink_application_configuration.value.parallelism
          parallelism_per_kpu  = flink_application_configuration.value.parallelism_per_kpu
        }
      }
    }
    vpc_configuration {
      subnet_ids         = var.subnet_ids
      security_group_ids = [var.security_group_id]
    }
  
}
  tags = try(var.tags, {})
}