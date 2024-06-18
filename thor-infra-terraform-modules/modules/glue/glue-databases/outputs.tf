output "glue_database_name" {
  value = element(split(":", aws_glue_catalog_database.glue_database.id), 1)
 description = "Glue catalog db name"
}