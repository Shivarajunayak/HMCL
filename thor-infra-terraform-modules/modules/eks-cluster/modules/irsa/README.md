# irsa

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
    
	 # Required variables
    	 eks_oidc_provider_arn  = 
    	 environment  = 
    	 role_name  = 
  
	 # Optional variables
  	 policy  = {}
  	 role_policy_path  = "/"
}
```
## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | OIDC provider ARN of EKS cluster | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | n/a | `any` | `{}` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | IRSA roles name | `string` | n/a | yes |
| <a name="input_role_policy_path"></a> [role\_policy\_path](#input\_role\_policy\_path) | n/a | `string` | `"/"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | IAM Role ARN |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
