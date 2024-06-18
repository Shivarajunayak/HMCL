variable "glue_version" {
  description = "The version of AWS Glue to use for the Glue Job"
  default     = "3.0"
}
variable "job_name" {
  description = "The name of the Glue job"
  type        = string
  default     = "my-glue-job"
}
variable "glue_scripts_bucket" {
  description = "The name of script bucket for glue"
  type        = string
  default     = "glue-scripts-bucket"
}
variable "job_description" {
  description = "Description of the Glue job"
  type        = string
  default     = "My Glue job for ETL processing"
}
variable "worker_type" {
  description = "The type of predefined worker that is allocated when a job runs. Accepts Standard, G.1X, G.2X"
  default     = "G.1X"
}
variable "number_of_workers" {
  description = "The number of worker nodes that are allocated when a job runs"
  type        = number
  default     = 10
}
variable "max_retries" {
  description = "The maximum number of times to retry this job if it fails"
  type        = number
  default     = 0
}
variable "timeout" {
  description = "The job timeout in minutes"
  type        = number
  default     = null
}
variable "s3_bucket_scripts" {
  description = "Name of the S3 bucket to store Glue job scripts"
  type        = string
  default     = "glue-scripts-bucket"
}
variable "s3_bucket_results" {
  description = "Name of the S3 bucket to store Glue job results"
  type        = string
  default     = "glue-results-bucket"
}
variable "glue_role_arn" {
  description = "ARN of the IAM role for Glue job"
  type        = string
  default     = ""
}
variable "managed_policy_arn" {
  description = "Managed policy ARN to attach to the IAM role"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
variable "table_name" {
  description = "Name of the Glue catalog table"
  type        = string
  default     = "my_glue_table"
}
variable "data_location" {
  description = "Location of the data for the Glue catalog table"
  type        = string
  default     = "s3://my-data-bucket/data/"
}
variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}
variable "acl" {
  description = "(Optional) The canned ACL to apply. Conflicts with `grant`"
  type        = string
  default     = "private"
}
variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role associated with this job."
  default = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

variable "connections" {
  type        = list(string)
  description = "The list of connections with this job."
  default = []
}

variable "default_arguments" {
  type        = map(string)
  description = "The map of default arguments for the job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes."
  default     = null
}
variable "non_overridable_arguments" {
  type        = map(string)
  description = "Non-overridable arguments for this job, specified as name-value pairs."
  default     = null
}
variable "security_configuration" {
  type        = string
  description = "The name of the Security Configuration to be associated with the job."
  default     = null
}
variable "max_capacity" {
  type        = number
  description = "The maximum number of AWS Glue data processing units (DPUs) that can be allocated when the job runs. Required when `pythonshell` is set, accept either 0.0625 or 1.0. Use `number_of_workers` and `worker_type` arguments instead with `glue_version` 2.0 and above."
  default     = null
}

variable "command" {
  type = object({
    name            = string
    script_location = string
    python_version  = number
  })
  default = {
    name            = "glueetl"
    script_location = "s3://your-scripts-bucket/your-script.py"
    python_version  = 3
  }
  description = "The command of the job."
}


variable "execution_properties" {
  type        = any
  description = "Execution Properties"
  default     = {}
}

variable "data_source" {
  description = "Configuration for the data source"
  type        = object({
    location         = string
    input_format     = string
    output_format    = string
    serde_info       = object({
      name = string
      serialization_library = string
    })
  })
  default     = {
    location      = "s3://your-source-bucket/path/"
    input_format  = "org.apache.hudi.hadoop.HoodieParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    serde_info    = {
      name                  = "my-table"
      serialization_library = "    org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }
  }
}



variable "job_parameters" {
  description = "Job-specific parameters"
  type        = any
}

variable "extra_jars" {
  description = "Comma-separated list of S3 paths to the JAR files"
  type        = string
  default     = "s3://hmcl-cvp-thor-demo/aws-msk-iam-auth-1.1.1-all.jar"
}
