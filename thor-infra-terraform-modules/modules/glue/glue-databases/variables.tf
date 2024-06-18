variable "database_name" {
  description = "Name of the Glue catalog database"
  type        = string
  default     = "my_glue_database"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}