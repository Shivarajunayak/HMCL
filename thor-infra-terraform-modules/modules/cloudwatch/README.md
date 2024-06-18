# cloudwatch

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-cloudwatch/README.md updated successfully
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
  
	 # Optional variables
  	 create  = true
  	 default_kms_key_id  = ""
  	 default_log_group_class  = "STANDARD"
  	 default_retention_in_days  = 30
  	 default_skip_destroy  = false
  	 log_groups  = [
  {
    "kms_key_id": "",
    "log_group_class": "STANDARD",
    "name": "log-group-1",
    "retention_in_days": 7,
    "skip_destroy": true,
    "tags": {
      "Environment": "Production"
    }
  },
  {
    "kms_key_id": "",
    "log_group_class": "STANDARD",
    "name": "log-group-2",
    "retention_in_days": 14,
    "skip_destroy": false,
    "tags": {
      "Environment": "Staging"
    }
  }
]
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Boolean flag to control the creation of resources | `bool` | `true` | no |
| <a name="input_default_kms_key_id"></a> [default\_kms\_key\_id](#input\_default\_kms\_key\_id) | Default KMS key ID | `string` | `""` | no |
| <a name="input_default_log_group_class"></a> [default\_log\_group\_class](#input\_default\_log\_group\_class) | Default log group class | `string` | `"STANDARD"` | no |
| <a name="input_default_retention_in_days"></a> [default\_retention\_in\_days](#input\_default\_retention\_in\_days) | Default retention period for log groups | `number` | `30` | no |
| <a name="input_default_skip_destroy"></a> [default\_skip\_destroy](#input\_default\_skip\_destroy) | Default value for skip destroy | `bool` | `false` | no |
| <a name="input_log_groups"></a> [log\_groups](#input\_log\_groups) | List of log group configurations | <pre>list(object({<br>    name              = string<br>    retention_in_days = number<br>    kms_key_id        = string<br>    log_group_class   = string<br>    skip_destroy      = bool<br>    tags              = map(string)<br>  }))</pre> | <pre>[<br>  {<br>    "kms_key_id": "",<br>    "log_group_class": "STANDARD",<br>    "name": "log-group-1",<br>    "retention_in_days": 7,<br>    "skip_destroy": true,<br>    "tags": {<br>      "Environment": "Production"<br>    }<br>  },<br>  {<br>    "kms_key_id": "",<br>    "log_group_class": "STANDARD",<br>    "name": "log-group-2",<br>    "retention_in_days": 14,<br>    "skip_destroy": false,<br>    "tags": {<br>      "Environment": "Staging"<br>    }<br>  }<br>]</pre> | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->