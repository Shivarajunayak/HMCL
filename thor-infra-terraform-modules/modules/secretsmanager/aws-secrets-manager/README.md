# terraform-aws-secrets-manager-master

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Optional variables
  	 automatically_after_days  = 30
  	 recovery_window_in_days  = 30
  	 rotate_secrets  = {}
  	 rotation_enabled  = false
  	 secrets  = {}
  	 tags  = {}
  	 unmanaged  = true
  	 version_stages  = null
}
```
## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.sm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_rotation.sm_sr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_secretsmanager_secret_version.sm_sv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatically_after_days"></a> [automatically\_after\_days](#input\_automatically\_after\_days) | Specifies the number of days between automatic scheduled rotations of the secret. | `number` | `30` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. | `number` | `30` | no |
| <a name="input_rotate_secrets"></a> [rotate\_secrets](#input\_rotate\_secrets) | Map of secrets to keep and rotate in AWS Secrets Manager | `any` | `{}` | no |
| <a name="input_rotation_enabled"></a> [rotation\_enabled](#input\_rotation\_enabled) | Whether secret should be rotated | `bool` | `false` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Map of secrets to keep in AWS Secrets Manager | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a key-value map of user-defined tags that are attached to the secret. | `any` | `{}` | no |
| <a name="input_unmanaged"></a> [unmanaged](#input\_unmanaged) | Terraform must ignore secrets lifecycle. Using this option you can initialize the secrets and rotate them outside Terraform, thus, avoiding other users to change or rotate the secrets by subsequent runs of Terraform | `bool` | `true` | no |
| <a name="input_version_stages"></a> [version\_stages](#input\_version\_stages) | List of version stages to be handled. Kept as null for backwards compatibility. | `list(string)` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_arns"></a> [secret\_arns](#output\_secret\_arns) | Secrets arns map |
| <a name="output_secret_ids"></a> [secret\_ids](#output\_secret\_ids) | Secret ids map |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
