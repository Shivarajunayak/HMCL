# stepfunctions

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-step-functions/README.md updated successfully
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
  	 attach_cloudwatch_logs_policy  = true
  	 attach_policies  = false
  	 attach_policies_for_integrations  = true
  	 attach_policy  = false
  	 attach_policy_json  = false
  	 attach_policy_jsons  = false
  	 attach_policy_statements  = false
  	 aws_region_assume_role  = ""
  	 cloudwatch_log_group_kms_key_id  = null
  	 cloudwatch_log_group_name  = null
  	 cloudwatch_log_group_retention_in_days  = null
  	 cloudwatch_log_group_tags  = {}
  	 create  = true
  	 create_role  = true
  	 definition  = "{\n  \"StartAt\": \"Step1\",\n  \"States\": {\n    \"Step1\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test5\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step1\",\n        \"param2.$\": \"$.param2_step1\"\n      },\n      \"Next\": \"Step2\"\n    },\n    \"Step2\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test1\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step2\",\n        \"param2.$\": \"$.param2_step2\"\n      },\n      \"Next\": \"Step3\"\n    },\n    \"Step3\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test2\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step3\",\n        \"param2.$\": \"$.param2_step3\"\n      },\n      \"Next\": \"Step4\"\n    },\n    \"Step4\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test3\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step4\",\n        \"param2.$\": \"$.param2_step4\"\n      },\n      \"Next\": \"Step5\"\n    },\n    \"Step5\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test4\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step5\",\n        \"param2.$\": \"$.param2_step5\"\n      },\n      \"End\": true\n    }\n  }\n}\n"
  	 logging_configuration  = {}
  	 name  = ""
  	 number_of_policies  = 0
  	 number_of_policy_jsons  = 0
  	 policies  = []
  	 policy  = null
  	 policy_json  = null
  	 policy_jsons  = []
  	 policy_path  = null
  	 policy_statements  = {}
  	 publish  = false
  	 role_arn  = ""
  	 role_description  = null
  	 role_force_detach_policies  = true
  	 role_name  = null
  	 role_path  = null
  	 role_permissions_boundary  = null
  	 role_tags  = {}
  	 service_integrations  = {}
  	 sfn_state_machine_timeouts  = {}
  	 tags  = {}
  	 trusted_entities  = []
  	 type  = "STANDARD"
  	 use_existing_cloudwatch_log_group  = false
  	 use_existing_role  = false
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_cloudwatch_logs_policy"></a> [attach\_cloudwatch\_logs\_policy](#input\_attach\_cloudwatch\_logs\_policy) | Controls whether CloudWatch Logs policy should be added to IAM role for Lambda Function | `bool` | `true` | no |
| <a name="input_attach_policies"></a> [attach\_policies](#input\_attach\_policies) | Controls whether list of policies should be added to IAM role | `bool` | `false` | no |
| <a name="input_attach_policies_for_integrations"></a> [attach\_policies\_for\_integrations](#input\_attach\_policies\_for\_integrations) | Whether to attach AWS Service policies to IAM role | `bool` | `true` | no |
| <a name="input_attach_policy"></a> [attach\_policy](#input\_attach\_policy) | Controls whether policy should be added to IAM role | `bool` | `false` | no |
| <a name="input_attach_policy_json"></a> [attach\_policy\_json](#input\_attach\_policy\_json) | Controls whether policy\_json should be added to IAM role | `bool` | `false` | no |
| <a name="input_attach_policy_jsons"></a> [attach\_policy\_jsons](#input\_attach\_policy\_jsons) | Controls whether policy\_jsons should be added to IAM role | `bool` | `false` | no |
| <a name="input_attach_policy_statements"></a> [attach\_policy\_statements](#input\_attach\_policy\_statements) | Controls whether policy\_statements should be added to IAM role | `bool` | `false` | no |
| <a name="input_aws_region_assume_role"></a> [aws\_region\_assume\_role](#input\_aws\_region\_assume\_role) | Name of AWS regions where IAM role can be assumed by the Step Function | `string` | `""` | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | Name of Cloudwatch Logs group name to use. | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `null` | no |
| <a name="input_cloudwatch_log_group_tags"></a> [cloudwatch\_log\_group\_tags](#input\_cloudwatch\_log\_group\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create Step Function resource | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create IAM role for the Step Function | `bool` | `true` | no |
| <a name="input_definition"></a> [definition](#input\_definition) | The Amazon States Language definition of the Step Function | `string` | `"{\n  \"StartAt\": \"Step1\",\n  \"States\": {\n    \"Step1\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test5\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step1\",\n        \"param2.$\": \"$.param2_step1\"\n      },\n      \"Next\": \"Step2\"\n    },\n    \"Step2\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test1\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step2\",\n        \"param2.$\": \"$.param2_step2\"\n      },\n      \"Next\": \"Step3\"\n    },\n    \"Step3\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test2\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step3\",\n        \"param2.$\": \"$.param2_step3\"\n      },\n      \"Next\": \"Step4\"\n    },\n    \"Step4\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test3\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step4\",\n        \"param2.$\": \"$.param2_step4\"\n      },\n      \"Next\": \"Step5\"\n    },\n    \"Step5\": {\n      \"Type\": \"Task\",\n      \"Resource\": \"arn:aws:lambda:eu-west-1:123456789012:function:test4\",\n      \"Parameters\": {\n        \"param1.$\": \"$.param1_step5\",\n        \"param2.$\": \"$.param2_step5\"\n      },\n      \"End\": true\n    }\n  }\n}\n"` | no |
| <a name="input_logging_configuration"></a> [logging\_configuration](#input\_logging\_configuration) | Defines what execution history events are logged and where they are logged | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Step Function | `string` | `""` | no |
| <a name="input_number_of_policies"></a> [number\_of\_policies](#input\_number\_of\_policies) | Number of policies to attach to IAM role | `number` | `0` | no |
| <a name="input_number_of_policy_jsons"></a> [number\_of\_policy\_jsons](#input\_number\_of\_policy\_jsons) | Number of policies JSON to attach to IAM role | `number` | `0` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of policy statements ARN to attach to IAM role | `list(string)` | `[]` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | An additional policy document ARN to attach to IAM role | `string` | `null` | no |
| <a name="input_policy_json"></a> [policy\_json](#input\_policy\_json) | An additional policy document as JSON to attach to IAM role | `string` | `null` | no |
| <a name="input_policy_jsons"></a> [policy\_jsons](#input\_policy\_jsons) | List of additional policy documents as JSON to attach to IAM role | `list(string)` | `[]` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path of IAM policies to use for Step Function | `string` | `null` | no |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | Map of dynamic policy statements to attach to IAM role | `any` | `{}` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Determines whether to set a version of the state machine when it is created. | `bool` | `false` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The Amazon Resource Name (ARN) of the IAM role to use for this Step Function | `string` | `""` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | Description of IAM role to use for Step Function | `string` | `null` | no |
| <a name="input_role_force_detach_policies"></a> [role\_force\_detach\_policies](#input\_role\_force\_detach\_policies) | Specifies to force detaching any policies the IAM role has before destroying it. | `bool` | `true` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role to use for Step Function | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role to use for Step Function | `string` | `null` | no |
| <a name="input_role_permissions_boundary"></a> [role\_permissions\_boundary](#input\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the IAM role used by Step Function | `string` | `null` | no |
| <a name="input_role_tags"></a> [role\_tags](#input\_role\_tags) | A map of tags to assign to IAM role | `map(string)` | `{}` | no |
| <a name="input_service_integrations"></a> [service\_integrations](#input\_service\_integrations) | Map of AWS service integrations to allow in IAM role policy | `any` | `{}` | no |
| <a name="input_sfn_state_machine_timeouts"></a> [sfn\_state\_machine\_timeouts](#input\_sfn\_state\_machine\_timeouts) | Create, update, and delete timeout configurations for the step function. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Maps of tags to assign to the Step Function | `map(string)` | `{}` | no |
| <a name="input_trusted_entities"></a> [trusted\_entities](#input\_trusted\_entities) | Step Function additional trusted entities for assuming roles (trust relationship) | `list(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | Determines whether a Standard or Express state machine is created. The default is STANDARD. Valid Values: STANDARD \| EXPRESS | `string` | `"STANDARD"` | no |
| <a name="input_use_existing_cloudwatch_log_group"></a> [use\_existing\_cloudwatch\_log\_group](#input\_use\_existing\_cloudwatch\_log\_group) | Whether to use an existing CloudWatch log group or create new | `bool` | `false` | no |
| <a name="input_use_existing_role"></a> [use\_existing\_role](#input\_use\_existing\_role) | Whether to use an existing IAM role for this Step Function | `bool` | `false` | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
