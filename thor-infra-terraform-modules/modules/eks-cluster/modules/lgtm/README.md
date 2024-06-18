# lgtm

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
values/README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
    
	 # Required variables
    	 acm_certificate_arn  = 
    	 eks_oidc_provider_arn  = 
  
	 # Optional variables
  	 alertmgr_bucket_name  = "eks-alertmgr"
  	 enable_mimir  = false
  	 environment  = "sandbox"
  	 loki_bucket_name  = "sandbox-eks-loki"
  	 mimir_bucket_name  = "eks-mimir"
  	 role_policy_path  = "/"
  	 ruler_bucket_name  = "eks-ruler"
}
```
## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.alertmgr_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.loki_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.mimir_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.ruler_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.alertmgr_bucket_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.loki_s3_bucket_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.mimir_s3_bucket_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.ruler_bucket_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [helm_release.grafana](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.grafana_loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.grafana_loki_ingress](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | n/a | `string` | n/a | yes |
| <a name="input_alertmgr_bucket_name"></a> [alertmgr\_bucket\_name](#input\_alertmgr\_bucket\_name) | Bucket name for AlertMgr S3 bucket | `string` | `"eks-alertmgr"` | no |
| <a name="input_eks_oidc_provider_arn"></a> [eks\_oidc\_provider\_arn](#input\_eks\_oidc\_provider\_arn) | OIDC provider ARN of EKS cluster | `string` | n/a | yes |
| <a name="input_enable_mimir"></a> [enable\_mimir](#input\_enable\_mimir) | n/a | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | `"sandbox"` | no |
| <a name="input_loki_bucket_name"></a> [loki\_bucket\_name](#input\_loki\_bucket\_name) | Bucket name for Loki S3 bucket | `string` | `"sandbox-eks-loki"` | no |
| <a name="input_mimir_bucket_name"></a> [mimir\_bucket\_name](#input\_mimir\_bucket\_name) | Bucket name for Mimir S3 bucket | `string` | `"eks-mimir"` | no |
| <a name="input_role_policy_path"></a> [role\_policy\_path](#input\_role\_policy\_path) | n/a | `string` | `"/"` | no |
| <a name="input_ruler_bucket_name"></a> [ruler\_bucket\_name](#input\_ruler\_bucket\_name) | Bucket name for Ruler S3 bucket | `string` | `"eks-ruler"` | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
