resource "aws_glue_job" "glue_job" {
  name                  = coalesce(var.job_name, "my-glue-job")
  description           = var.job_description
  role_arn              = var.glue_role_arn
  glue_version          = var.glue_version
  worker_type           = var.worker_type
  number_of_workers     = var.number_of_workers
  max_retries           = var.max_retries
  timeout               = var.timeout
  command {
    name            = lookup(var.command, "name", "glueetl")
    script_location = lookup(var.command, "script_location", "s3://${var.glue_scripts_bucket}/script/")
    python_version  = lookup(var.command, "python_version", "3")
  }
  non_overridable_arguments = var.non_overridable_arguments
  security_configuration    = var.security_configuration
  connections               = var.connections   
  default_arguments =     var.job_parameters
  
  dynamic "execution_property" {
      for_each = var.execution_properties
      content {
          max_concurrent_runs = execution_property.value.max_concurrent_runs
      }
    }


  tags = var.tags
}