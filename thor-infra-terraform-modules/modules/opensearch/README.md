# opensearch

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-opensearch/README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Optional variables
  	 access_policies  = null
  	 access_policy_override_policy_documents  = []
  	 access_policy_source_policy_documents  = []
  	 access_policy_statements  = {}
  	 advanced_options  = {}
  	 advanced_security_options  = {
  "anonymous_auth_enabled": false,
  "enabled": true
}
  	 auto_tune_options  = {
  "desired_state": "ENABLED",
  "rollback_on_disable": "NO_ROLLBACK"
}
  	 cloudwatch_log_group_kms_key_id  = null
  	 cloudwatch_log_group_retention_in_days  = 60
  	 cloudwatch_log_resource_policy_name  = null
  	 cluster_config  = {
  "dedicated_master_enabled": true
}
  	 cognito_options  = {}
  	 create  = true
  	 create_access_policy  = true
  	 create_cloudwatch_log_groups  = true
  	 create_cloudwatch_log_resource_policy  = true
  	 create_saml_options  = false
  	 create_security_group  = true
  	 domain_endpoint_options  = {
  "enforce_https": true,
  "tls_security_policy": "Policy-Min-TLS-1-2-2019-07"
}
  	 domain_name  = "my-domain"
  	 ebs_options  = {
  "ebs_enabled": true,
  "volume_size": 64,
  "volume_type": "gp3"
}
  	 enable_access_policy  = true
  	 encrypt_at_rest  = {
  "enabled": true
}
  	 engine_version  = "OpenSearch_2.11"
  	 log_publishing_options  = [
  {
    "log_type": "INDEX_SLOW_LOGS"
  },
  {
    "log_type": "SEARCH_SLOW_LOGS"
  }
]
  	 node_to_node_encryption  = {
  "enabled": true
}
  	 off_peak_window_options  = {
  "enabled": true,
  "off_peak_window": {
    "hours": 7
  }
}
  	 outbound_connections  = {}
  	 package_associations  = {}
  	 saml_options  = {}
  	 security_group_description  = null
  	 security_group_name  = null
  	 security_group_rules  = {}
  	 security_group_tags  = {}
  	 security_group_use_name_prefix  = true
  	 software_update_options  = {
  "auto_software_update_enabled": true
}
  	 tags  = {}
  	 vpc_endpoints  = {}
  	 vpc_options  = {
  "subnet_ids": [
    "subnet-0aa981de6375daa02",
    "subnet-0683ae659ea2dccd3"
  ]
}
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | IAM policy document specifying the access policies for the domain. Required if `create_access_policy` is `false` | `string` | `null` | no |
| <a name="input_access_policy_override_policy_documents"></a> [access\_policy\_override\_policy\_documents](#input\_access\_policy\_override\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid` | `list(string)` | `[]` | no |
| <a name="input_access_policy_source_policy_documents"></a> [access\_policy\_source\_policy\_documents](#input\_access\_policy\_source\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s | `list(string)` | `[]` | no |
| <a name="input_access_policy_statements"></a> [access\_policy\_statements](#input\_access\_policy\_statements) | A map of IAM policy statements for custom permission usage | `any` | `{}` | no |
| <a name="input_advanced_options"></a> [advanced\_options](#input\_advanced\_options) | Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply | `map(string)` | `{}` | no |
| <a name="input_advanced_security_options"></a> [advanced\_security\_options](#input\_advanced\_security\_options) | Configuration block for fine-grained access control | `any` | <pre>{<br>  "anonymous_auth_enabled": false,<br>  "enabled": true<br>}</pre> | no |
| <a name="input_auto_tune_options"></a> [auto\_tune\_options](#input\_auto\_tune\_options) | Configuration block for the Auto-Tune options of the domain | `any` | <pre>{<br>  "desired_state": "ENABLED",<br>  "rollback_on_disable": "NO_ROLLBACK"<br>}</pre> | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Number of days to retain log events | `number` | `60` | no |
| <a name="input_cloudwatch_log_resource_policy_name"></a> [cloudwatch\_log\_resource\_policy\_name](#input\_cloudwatch\_log\_resource\_policy\_name) | Name of the resource policy for OpenSearch to log to CloudWatch | `string` | `null` | no |
| <a name="input_cluster_config"></a> [cluster\_config](#input\_cluster\_config) | Configuration block for the cluster of the domain | `any` | <pre>{<br>  "dedicated_master_enabled": true<br>}</pre> | no |
| <a name="input_cognito_options"></a> [cognito\_options](#input\_cognito\_options) | Configuration block for authenticating Kibana with Cognito | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_access_policy"></a> [create\_access\_policy](#input\_create\_access\_policy) | Determines whether an access policy will be created | `bool` | `true` | no |
| <a name="input_create_cloudwatch_log_groups"></a> [create\_cloudwatch\_log\_groups](#input\_create\_cloudwatch\_log\_groups) | Determines whether log groups are created | `bool` | `true` | no |
| <a name="input_create_cloudwatch_log_resource_policy"></a> [create\_cloudwatch\_log\_resource\_policy](#input\_create\_cloudwatch\_log\_resource\_policy) | Determines whether a resource policy will be created for OpenSearch to log to CloudWatch | `bool` | `true` | no |
| <a name="input_create_saml_options"></a> [create\_saml\_options](#input\_create\_saml\_options) | Determines whether SAML options will be created | `bool` | `false` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines if a security group is created | `bool` | `true` | no |
| <a name="input_domain_endpoint_options"></a> [domain\_endpoint\_options](#input\_domain\_endpoint\_options) | Configuration block for domain endpoint HTTP(S) related options | `any` | <pre>{<br>  "enforce_https": true,<br>  "tls_security_policy": "Policy-Min-TLS-1-2-2019-07"<br>}</pre> | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the domain | `string` | `"my-domain"` | no |
| <a name="input_ebs_options"></a> [ebs\_options](#input\_ebs\_options) | Configuration block for EBS related options, may be required based on chosen instance size | `any` | <pre>{<br>  "ebs_enabled": true,<br>  "volume_size": 64,<br>  "volume_type": "gp3"<br>}</pre> | no |
| <a name="input_enable_access_policy"></a> [enable\_access\_policy](#input\_enable\_access\_policy) | Determines whether an access policy will be applied to the domain | `bool` | `true` | no |
| <a name="input_encrypt_at_rest"></a> [encrypt\_at\_rest](#input\_encrypt\_at\_rest) | Configuration block for encrypting at rest | `any` | <pre>{<br>  "enabled": true<br>}</pre> | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Version of the OpenSearch engine to use | `string` | `"OpenSearch_2.11"` | no |
| <a name="input_log_publishing_options"></a> [log\_publishing\_options](#input\_log\_publishing\_options) | Configuration block for publishing slow and application logs to CloudWatch Logs. This block can be declared multiple times, for each log\_type, within the same resource | <pre>list(object({<br>    log_type = string<br>  }))</pre> | <pre>[<br>  {<br>    "log_type": "INDEX_SLOW_LOGS"<br>  },<br>  {<br>    "log_type": "SEARCH_SLOW_LOGS"<br>  }<br>]</pre> | no |
| <a name="input_node_to_node_encryption"></a> [node\_to\_node\_encryption](#input\_node\_to\_node\_encryption) | Configuration block for node-to-node encryption options | `any` | <pre>{<br>  "enabled": true<br>}</pre> | no |
| <a name="input_off_peak_window_options"></a> [off\_peak\_window\_options](#input\_off\_peak\_window\_options) | Configuration to add Off Peak update options | `any` | <pre>{<br>  "enabled": true,<br>  "off_peak_window": {<br>    "hours": 7<br>  }<br>}</pre> | no |
| <a name="input_outbound_connections"></a> [outbound\_connections](#input\_outbound\_connections) | Map of AWS OpenSearch outbound connections to create | `any` | `{}` | no |
| <a name="input_package_associations"></a> [package\_associations](#input\_package\_associations) | Map of package association IDs to associate with the domain | `map(string)` | `{}` | no |
| <a name="input_saml_options"></a> [saml\_options](#input\_saml\_options) | SAML authentication options for an AWS OpenSearch Domain | `any` | `{}` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | Description of the security group created | `string` | `null` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name to use on security group created | `string` | `null` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Security group ingress and egress rules to add to the security group created | `any` | `{}` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_software_update_options"></a> [software\_update\_options](#input\_software\_update\_options) | Software update options for the domain | `any` | <pre>{<br>  "auto_software_update_enabled": true<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_endpoints"></a> [vpc\_endpoints](#input\_vpc\_endpoints) | Map of VPC endpoints to create for the domain | `any` | `{}` | no |
| <a name="input_vpc_options"></a> [vpc\_options](#input\_vpc\_options) | Configuration block for VPC related options. Adding or removing this configuration forces a new resource | `any` | <pre>{<br>  "subnet_ids": [<br>    "subnet-0aa981de6375daa02",<br>    "subnet-0683ae659ea2dccd3"<br>  ]<br>}</pre> | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->