# sqs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-sqs/README.md updated successfully
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
  	 sqs_queues  = {}
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sqs_queues"></a> [sqs\_queues](#input\_sqs\_queues) | object consisting of details for SqS queues | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all_dead_letter_queue_arns"></a> [all\_dead\_letter\_queue\_arns](#output\_all\_dead\_letter\_queue\_arns) | DLQ SqS queue arns Map |
| <a name="output_all_dead_letter_queue_ids"></a> [all\_dead\_letter\_queue\_ids](#output\_all\_dead\_letter\_queue\_ids) | DLQ SqS queue URLs Map |
| <a name="output_all_sqs_queue_arns"></a> [all\_sqs\_queue\_arns](#output\_all\_sqs\_queue\_arns) | SqS queue arns Map |
| <a name="output_all_sqs_queue_ids"></a> [all\_sqs\_queue\_ids](#output\_all\_sqs\_queue\_ids) | SqS queue URLs Map |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
