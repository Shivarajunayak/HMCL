# iot-policies

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
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
  	 iot_policies  = {}
  	 tags  = {}
}
```
## Resources

| Name | Type |
|------|------|
| [aws_iot_policy.iot_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iot_policy) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_iot_policies"></a> [iot\_policies](#input\_iot\_policies) | n/a | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iot_policy_arns"></a> [iot\_policy\_arns](#output\_iot\_policy\_arns) | ARNs of IOT Policies |
| <a name="output_iot_policy_names"></a> [iot\_policy\_names](#output\_iot\_policy\_names) | Names of IOT Policies |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->