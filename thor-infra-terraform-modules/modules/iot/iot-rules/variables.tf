variable "iot_topic_rules" {
  type = map(object({
    rule_name        = string
    sql              = string
    sql_version      = string
    description      = string
    tags             = map(string)
    needs_iam        = bool
    assume_role_policy_action       = string
    custom_policy_action            = string
    action = object({
      lambda    = optional(object({ function_arn = string }))
      dynamodb  = optional(object({
        table_name = string
        hash_key_field  = string
        hash_key_value  = string
      }))
      kafka     = optional(object({
        destination_arn   = string
        topic             = string
        key               = string
        client_properties = map(string)
      }))
      republish = optional(object({
        topic = string
        qos   = number
      }))
    })
    error_action  = optional(object({
      dynamodb        = optional(object({
        table_name     = string
        hash_key_field = string
        hash_key_value = string
      }))
      kafka           = optional(object({
        destination_arn   = string
        topic             = string
        key               = string
        client_properties = object({
          bootstrap_servers = string
          security_protocol = string
          sasl_mechanism    = string
          sasl_secret_name  = string
          compression_type  = string
          acks              = string
        })
      }))
      lambda          = optional(object({
        function_arn = string
      }))
      cloudwatch_logs = optional(object({
        log_group_name = string  
      }))
      republish       = optional(object({
        topic = string
        qos   = number
      }))
    }))
  }))
}

variable "cloudwatch_log_group" {
  description = "Name of CloudWatch Log Group"
  type        = string
  default     = ""
}
