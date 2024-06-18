# dynamodb

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-dynamodb/README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Optional variables
  	 dax_parameter_group_query_ttl  = "300000"
  	 dax_parameter_group_record_ttl  = "300000"
  	 dynamodb_table  = {}
  	 enable_dax  = false
  	 iam_role_arn  = "arn:aws:iam::637423293078:role/DAX_to_call_DynamoDB"
  	 maintenance_window  = "sun:00:00-sun:01:00"
  	 name  = "cluster-example"
  	 node_count  = 1
  	 node_type  = "dax.r4.large"
  	 security_group_ids  = [
  "sg-0df4d2cea812f1245"
]
  	 server_side_encryption  = true
  	 subnet_ids  = [
  "subnet-096d3559ef7c6999c"
]
  	 tags  = {
  "Environment": "Dev",
  "Owner": "Gowda"
}
}
```
## Resources

| Name | Type |
|------|------|
| [aws_dax_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_cluster) | resource |
| [aws_dax_parameter_group.parameter_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_parameter_group) | resource |
| [aws_dax_subnet_group.subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_subnet_group) | resource |
| [aws_dynamodb_table.dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dax_parameter_group_query_ttl"></a> [dax\_parameter\_group\_query\_ttl](#input\_dax\_parameter\_group\_query\_ttl) | (optional) Query Time To Live in milliseconds Defaults: 300000 | `string` | `"300000"` | no |
| <a name="input_dax_parameter_group_record_ttl"></a> [dax\_parameter\_group\_record\_ttl](#input\_dax\_parameter\_group\_record\_ttl) | (optional) Record Time To Live in milliseconds Defaults: 300000 | `string` | `"300000"` | no |
| <a name="input_dynamodb_table"></a> [dynamodb\_table](#input\_dynamodb\_table) | n/a | `any` | `{}` | no |
| <a name="input_enable_dax"></a> [enable\_dax](#input\_enable\_dax) | Whether to enable dax cluster | `bool` | `false` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | (Required) A valid Amazon Resource Name (ARN) that identifies an IAM role. At runtime, DAX will assume this role and use the role's permissions to access DynamoDB on your behalf | `string` | `"arn:aws:iam::637423293078:role/DAX_to_call_DynamoDB"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) Specifies the weekly time range for when maintenance on the cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Defaults: sun:00:00-sun:01:00 | `string` | `"sun:00:00-sun:01:00"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of Cluster | `string` | `"cluster-example"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | (Required) The number of nodes in the DAX cluster. If 1 then it will create a single-node cluster, without any read replicas [ Default to 1 ] | `number` | `1` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | (Required) The compute and memory capacity of the nodes | `string` | `"dax.r4.large"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | (Required) One or more VPC security groups associated with the cluster | `list(string)` | <pre>[<br>  "sg-0df4d2cea812f1245"<br>]</pre> | no |
| <a name="input_server_side_encryption"></a> [server\_side\_encryption](#input\_server\_side\_encryption) | (Optional) Encrypt at rest options Default = true | `bool` | `true` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required) List of Subnets to use for Cluster Group | `list(string)` | <pre>[<br>  "subnet-096d3559ef7c6999c"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "Environment": "Dev",<br>  "Owner": "Gowda"<br>}</pre> | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_address"></a> [cluster\_address](#output\_cluster\_address) | DNS name of the DAX cluster without the port appended |
| <a name="output_configuration_endpoint"></a> [configuration\_endpoint](#output\_configuration\_endpoint) | Configuration endpoint for this DAX cluster, consisting of a DNS name and a port number |
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | arn of the created DynamoDB tables |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | name of the created DynamoDB tables |
| <a name="output_dynamodb_table_stream_arn"></a> [dynamodb\_table\_stream\_arn](#output\_dynamodb\_table\_stream\_arn) | Stream arn of the created DynamoDB tables |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
