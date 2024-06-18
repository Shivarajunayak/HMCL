# sns

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-sns/README.md updated successfully
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
  	 sns_topics  = {}
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sns_topics"></a> [sns\_topics](#input\_sns\_topics) | n/a | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_sns_topic_ids"></a> [all\_sns\_topic\_ids](#output\_all\_sns\_topic\_ids) | SnS topic ids Map |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
