resource "aws_glue_catalog_database" "glue_database" {
  name = var.database_name
  tags = var.tags
}