<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

No requirements.
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Optional variables
  	 allowed_pattern  = null
  	 create  = true
  	 data_type  = null
  	 description  = null
  	 ignore_value_changes  = false
  	 key_id  = null
  	 name  = null
  	 secure_type  = false
  	 tags  = {}
  	 tier  = null
  	 type  = null
  	 value  = null
  	 values  = []
}
```
## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.ignore_value](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_pattern"></a> [allowed\_pattern](#input\_allowed\_pattern) | Regular expression used to validate the parameter value. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create SSM Parameter | `bool` | `true` | no |
| <a name="input_data_type"></a> [data\_type](#input\_data\_type) | Data type of the parameter. Valid values: text, aws:ssm:integration and aws:ec2:image for AMI format. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the parameter | `string` | `null` | no |
| <a name="input_ignore_value_changes"></a> [ignore\_value\_changes](#input\_ignore\_value\_changes) | Whether to create SSM Parameter and ignore changes in value | `bool` | `false` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | KMS key ID or ARN for encrypting a parameter (when type is SecureString) | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of SSM parameter | `string` | `null` | no |
| <a name="input_secure_type"></a> [secure\_type](#input\_secure\_type) | Whether the type of the value should be considered as secure or not? | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Parameter tier to assign to the parameter. If not specified, will use the default parameter tier for the region. Valid tiers are Standard, Advanced, and Intelligent-Tiering. Downgrading an Advanced tier parameter to Standard will recreate the resource. | `string` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the parameter. Valid types are String, StringList and SecureString. | `string` | `null` | no |
| <a name="input_value"></a> [value](#input\_value) | Value of the parameter | `string` | `null` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values of the parameter (will be jsonencoded to store as string natively in SSM) | `list(string)` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_insecure_value"></a> [insecure\_value](#output\_insecure\_value) | Insecure value of the parameter |
| <a name="output_raw_value"></a> [raw\_value](#output\_raw\_value) | Raw value of the parameter (as it is stored in SSM). Use 'value' output to get jsondecode'd value |
| <a name="output_secure_type"></a> [secure\_type](#output\_secure\_type) | Whether SSM parameter is a SecureString or not? |
| <a name="output_secure_value"></a> [secure\_value](#output\_secure\_value) | Secure value of the parameter |
| <a name="output_ssm_parameter_arn"></a> [ssm\_parameter\_arn](#output\_ssm\_parameter\_arn) | The ARN of the parameter |
| <a name="output_ssm_parameter_name"></a> [ssm\_parameter\_name](#output\_ssm\_parameter\_name) | Name of the parameter |
| <a name="output_ssm_parameter_tags_all"></a> [ssm\_parameter\_tags\_all](#output\_ssm\_parameter\_tags\_all) | All tags used for the parameter |
| <a name="output_ssm_parameter_type"></a> [ssm\_parameter\_type](#output\_ssm\_parameter\_type) | Type of the parameter |
| <a name="output_ssm_parameter_version"></a> [ssm\_parameter\_version](#output\_ssm\_parameter\_version) | Version of the parameter |
| <a name="output_value"></a> [value](#output\_value) | Parameter value after jsondecode(). Probably this is what you are looking for |
<!-- END_AUTOMATED_TF_DOCS_BLOCK --><!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
