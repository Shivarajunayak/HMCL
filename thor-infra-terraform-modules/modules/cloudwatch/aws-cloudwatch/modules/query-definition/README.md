# query-definition

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
    
	 # Required variables
    	 name  = 
    	 query_string  = 
  
	 # Optional variables
  	 create  = true
  	 log_group_names  = null
}
```
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_query_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_query_definition) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create the Cloudwatch query definition | `bool` | `true` | no |
| <a name="input_log_group_names"></a> [log\_group\_names](#input\_log\_group\_names) | Specific log groups to use with the query. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the query. | `string` | n/a | yes |
| <a name="input_query_string"></a> [query\_string](#input\_query\_string) | The The query to save. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_query_definition_id"></a> [cloudwatch\_query\_definition\_id](#output\_cloudwatch\_query\_definition\_id) | The query definition id. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->