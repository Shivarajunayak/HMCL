# secretsmanager

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-secrets-manager/README.md updated successfully
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
  	 automatically_after_days  = 30
  	 rotation_enabled  = false
  	 secrets  = {}
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatically_after_days"></a> [automatically\_after\_days](#input\_automatically\_after\_days) | Specifies the number of days between automatic scheduled rotations of the secret. | `number` | `30` | no |
| <a name="input_rotation_enabled"></a> [rotation\_enabled](#input\_rotation\_enabled) | Whether secret should be rotated | `bool` | `false` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_secret_arns"></a> [all\_secret\_arns](#output\_all\_secret\_arns) | Secret arns map |
| <a name="output_all_secret_ids"></a> [all\_secret\_ids](#output\_all\_secret\_ids) | Secret ids map |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
