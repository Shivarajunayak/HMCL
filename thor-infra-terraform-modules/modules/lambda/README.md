# lambda

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-lambda/README.md updated successfully
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
  	 allowed_triggers  = {}
  	 architectures  = null
  	 artifacts_dir  = "builds"
  	 assume_role_policy_statements  = {}
  	 attach_async_event_policy  = false
  	 attach_cloudwatch_logs_policy  = true
  	 attach_create_log_group_permission  = true
  	 attach_dead_letter_policy  = false
  	 attach_network_policy  = false
  	 attach_policies  = false
  	 attach_policy  = false
  	 attach_policy_json  = false
  	 attach_policy_jsons  = false
  	 attach_policy_statements  = false
  	 attach_tracing_policy  = false
  	 authorization_type  = "NONE"
  	 build_in_docker  = false
  	 cloudwatch_logs_kms_key_id  = null
  	 cloudwatch_logs_retention_in_days  = null
  	 cloudwatch_logs_tags  = {}
  	 code_signing_config_arn  = null
  	 compatible_architectures  = null
  	 compatible_runtimes  = []
  	 cors  = {}
  	 create  = true
  	 create_async_event_config  = false
  	 create_current_version_allowed_triggers  = true
  	 create_current_version_async_event_config  = true
  	 create_function  = true
  	 create_lambda_function_url  = false
  	 create_layer  = false
  	 create_package  = true
  	 create_role  = true
  	 create_sam_metadata  = false
  	 create_unqualified_alias_allowed_triggers  = true
  	 create_unqualified_alias_async_event_config  = true
  	 create_unqualified_alias_lambda_function_url  = true
  	 dead_letter_target_arn  = null
  	 description  = ""
  	 destination_on_failure  = null
  	 destination_on_success  = null
  	 docker_additional_options  = []
  	 docker_build_root  = ""
  	 docker_entrypoint  = null
  	 docker_file  = ""
  	 docker_image  = ""
  	 docker_pip_cache  = null
  	 docker_with_ssh_agent  = false
  	 environment_variables  = {}
  	 ephemeral_storage_size  = 512
  	 event_source_mapping  = {}
  	 file_system_arn  = null
  	 file_system_local_mount_path  = null
  	 function_name  = ""
  	 function_tags  = {}
  	 handler  = ""
  	 hash_extra  = ""
  	 ignore_source_code_hash  = false
  	 image_config_command  = []
  	 image_config_entry_point  = []
  	 image_config_working_directory  = null
  	 image_uri  = null
  	 invoke_mode  = null
  	 kms_key_arn  = null
  	 lambda_at_edge  = false
  	 lambda_at_edge_logs_all_regions  = true
  	 lambda_role  = ""
  	 layer_name  = ""
  	 layer_skip_destroy  = false
  	 layers  = null
  	 license_info  = ""
  	 local_existing_package  = null
  	 logging_application_log_level  = "INFO"
  	 logging_log_format  = "Text"
  	 logging_log_group  = null
  	 logging_system_log_level  = "INFO"
  	 maximum_event_age_in_seconds  = null
  	 maximum_retry_attempts  = null
  	 memory_size  = 128
  	 number_of_policies  = 0
  	 number_of_policy_jsons  = 0
  	 package_type  = "Zip"
  	 policies  = []
  	 policy  = null
  	 policy_json  = null
  	 policy_jsons  = []
  	 policy_name  = null
  	 policy_path  = null
  	 policy_statements  = {}
  	 provisioned_concurrent_executions  = -1
  	 publish  = false
  	 recreate_missing_package  = true
  	 replace_security_groups_on_destroy  = null
  	 replacement_security_group_ids  = null
  	 reserved_concurrent_executions  = -1
  	 role_description  = null
  	 role_force_detach_policies  = true
  	 role_maximum_session_duration  = 3600
  	 role_name  = null
  	 role_path  = null
  	 role_permissions_boundary  = null
  	 role_tags  = {}
  	 runtime  = ""
  	 s3_acl  = "private"
  	 s3_bucket  = null
  	 s3_existing_package  = null
  	 s3_kms_key_id  = null
  	 s3_object_override_default_tags  = false
  	 s3_object_storage_class  = "ONEZONE_IA"
  	 s3_object_tags  = {}
  	 s3_object_tags_only  = false
  	 s3_prefix  = null
  	 s3_server_side_encryption  = null
  	 snap_start  = false
  	 source_path  = null
  	 store_on_s3  = false
  	 tags  = {}
  	 timeout  = 3
  	 timeouts  = {}
  	 tracing_mode  = null
  	 trigger_on_package_timestamp  = true
  	 trusted_entities  = []
  	 use_existing_cloudwatch_log_group  = false
  	 vpc_security_group_ids  = null
  	 vpc_subnet_ids  = null
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_triggers"></a> [allowed\_triggers](#input\_allowed\_triggers) | Map of allowed triggers to create Lambda permissions | `map(any)` | `{}` | no |
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Instruction set architecture for your Lambda function. Valid values are ["x86\_64"] and ["arm64"]. | `list(string)` | `null` | no |
| <a name="input_artifacts_dir"></a> [artifacts\_dir](#input\_artifacts\_dir) | Directory name where artifacts should be stored | `string` | `"builds"` | no |
| <a name="input_assume_role_policy_statements"></a> [assume\_role\_policy\_statements](#input\_assume\_role\_policy\_statements) | Map of dynamic policy statements for assuming Lambda Function role (trust relationship) | `any` | `{}` | no |
| <a name="input_attach_async_event_policy"></a> [attach\_async\_event\_policy](#input\_attach\_async\_event\_policy) | Controls whether async event policy should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_cloudwatch_logs_policy"></a> [attach\_cloudwatch\_logs\_policy](#input\_attach\_cloudwatch\_logs\_policy) | Controls whether CloudWatch Logs policy should be added to IAM role for Lambda Function | `bool` | `true` | no |
| <a name="input_attach_create_log_group_permission"></a> [attach\_create\_log\_group\_permission](#input\_attach\_create\_log\_group\_permission) | Controls whether to add the create log group permission to the CloudWatch logs policy | `bool` | `true` | no |
| <a name="input_attach_dead_letter_policy"></a> [attach\_dead\_letter\_policy](#input\_attach\_dead\_letter\_policy) | Controls whether SNS/SQS dead letter notification policy should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_network_policy"></a> [attach\_network\_policy](#input\_attach\_network\_policy) | Controls whether VPC/network policy should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_policies"></a> [attach\_policies](#input\_attach\_policies) | Controls whether list of policies should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_policy"></a> [attach\_policy](#input\_attach\_policy) | Controls whether policy should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_policy_json"></a> [attach\_policy\_json](#input\_attach\_policy\_json) | Controls whether policy\_json should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_policy_jsons"></a> [attach\_policy\_jsons](#input\_attach\_policy\_jsons) | Controls whether policy\_jsons should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_policy_statements"></a> [attach\_policy\_statements](#input\_attach\_policy\_statements) | Controls whether policy\_statements should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_attach_tracing_policy"></a> [attach\_tracing\_policy](#input\_attach\_tracing\_policy) | Controls whether X-Ray tracing policy should be added to IAM role for Lambda Function | `bool` | `false` | no |
| <a name="input_authorization_type"></a> [authorization\_type](#input\_authorization\_type) | The type of authentication that the Lambda Function URL uses. Set to 'AWS\_IAM' to restrict access to authenticated IAM users only. Set to 'NONE' to bypass IAM authentication and create a public endpoint. | `string` | `"NONE"` | no |
| <a name="input_build_in_docker"></a> [build\_in\_docker](#input\_build\_in\_docker) | Whether to build dependencies in Docker | `bool` | `false` | no |
| <a name="input_cloudwatch_logs_kms_key_id"></a> [cloudwatch\_logs\_kms\_key\_id](#input\_cloudwatch\_logs\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data. | `string` | `null` | no |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `null` | no |
| <a name="input_cloudwatch_logs_tags"></a> [cloudwatch\_logs\_tags](#input\_cloudwatch\_logs\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_code_signing_config_arn"></a> [code\_signing\_config\_arn](#input\_code\_signing\_config\_arn) | Amazon Resource Name (ARN) for a Code Signing Configuration | `string` | `null` | no |
| <a name="input_compatible_architectures"></a> [compatible\_architectures](#input\_compatible\_architectures) | A list of Architectures Lambda layer is compatible with. Currently x86\_64 and arm64 can be specified. | `list(string)` | `null` | no |
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified. | `list(string)` | `[]` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | CORS settings to be used by the Lambda Function URL | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether resources should be created | `bool` | `true` | no |
| <a name="input_create_async_event_config"></a> [create\_async\_event\_config](#input\_create\_async\_event\_config) | Controls whether async event configuration for Lambda Function/Alias should be created | `bool` | `false` | no |
| <a name="input_create_current_version_allowed_triggers"></a> [create\_current\_version\_allowed\_triggers](#input\_create\_current\_version\_allowed\_triggers) | Whether to allow triggers on current version of Lambda Function (this will revoke permissions from previous version because Terraform manages only current resources) | `bool` | `true` | no |
| <a name="input_create_current_version_async_event_config"></a> [create\_current\_version\_async\_event\_config](#input\_create\_current\_version\_async\_event\_config) | Whether to allow async event configuration on current version of Lambda Function (this will revoke permissions from previous version because Terraform manages only current resources) | `bool` | `true` | no |
| <a name="input_create_function"></a> [create\_function](#input\_create\_function) | Controls whether Lambda Function resource should be created | `bool` | `true` | no |
| <a name="input_create_lambda_function_url"></a> [create\_lambda\_function\_url](#input\_create\_lambda\_function\_url) | Controls whether the Lambda Function URL resource should be created | `bool` | `false` | no |
| <a name="input_create_layer"></a> [create\_layer](#input\_create\_layer) | Controls whether Lambda Layer resource should be created | `bool` | `false` | no |
| <a name="input_create_package"></a> [create\_package](#input\_create\_package) | Controls whether Lambda package should be created | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Controls whether IAM role for Lambda Function should be created | `bool` | `true` | no |
| <a name="input_create_sam_metadata"></a> [create\_sam\_metadata](#input\_create\_sam\_metadata) | Controls whether the SAM metadata null resource should be created | `bool` | `false` | no |
| <a name="input_create_unqualified_alias_allowed_triggers"></a> [create\_unqualified\_alias\_allowed\_triggers](#input\_create\_unqualified\_alias\_allowed\_triggers) | Whether to allow triggers on unqualified alias pointing to $LATEST version | `bool` | `true` | no |
| <a name="input_create_unqualified_alias_async_event_config"></a> [create\_unqualified\_alias\_async\_event\_config](#input\_create\_unqualified\_alias\_async\_event\_config) | Whether to allow async event configuration on unqualified alias pointing to $LATEST version | `bool` | `true` | no |
| <a name="input_create_unqualified_alias_lambda_function_url"></a> [create\_unqualified\_alias\_lambda\_function\_url](#input\_create\_unqualified\_alias\_lambda\_function\_url) | Whether to use unqualified alias pointing to $LATEST version in Lambda Function URL | `bool` | `true` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | The ARN of an SNS topic or SQS queue to notify when an invocation fails. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of your Lambda Function (or Layer) | `string` | `""` | no |
| <a name="input_destination_on_failure"></a> [destination\_on\_failure](#input\_destination\_on\_failure) | Amazon Resource Name (ARN) of the destination resource for failed asynchronous invocations | `string` | `null` | no |
| <a name="input_destination_on_success"></a> [destination\_on\_success](#input\_destination\_on\_success) | Amazon Resource Name (ARN) of the destination resource for successful asynchronous invocations | `string` | `null` | no |
| <a name="input_docker_additional_options"></a> [docker\_additional\_options](#input\_docker\_additional\_options) | Additional options to pass to the docker run command (e.g. to set environment variables, volumes, etc.) | `list(string)` | `[]` | no |
| <a name="input_docker_build_root"></a> [docker\_build\_root](#input\_docker\_build\_root) | Root dir where to build in Docker | `string` | `""` | no |
| <a name="input_docker_entrypoint"></a> [docker\_entrypoint](#input\_docker\_entrypoint) | Path to the Docker entrypoint to use | `string` | `null` | no |
| <a name="input_docker_file"></a> [docker\_file](#input\_docker\_file) | Path to a Dockerfile when building in Docker | `string` | `""` | no |
| <a name="input_docker_image"></a> [docker\_image](#input\_docker\_image) | Docker image to use for the build | `string` | `""` | no |
| <a name="input_docker_pip_cache"></a> [docker\_pip\_cache](#input\_docker\_pip\_cache) | Whether to mount a shared pip cache folder into docker environment or not | `any` | `null` | no |
| <a name="input_docker_with_ssh_agent"></a> [docker\_with\_ssh\_agent](#input\_docker\_with\_ssh\_agent) | Whether to pass SSH\_AUTH\_SOCK into docker environment or not | `bool` | `false` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A map that defines environment variables for the Lambda Function. | `map(string)` | `{}` | no |
| <a name="input_ephemeral_storage_size"></a> [ephemeral\_storage\_size](#input\_ephemeral\_storage\_size) | Amount of ephemeral storage (/tmp) in MB your Lambda Function can use at runtime. Valid value between 512 MB to 10,240 MB (10 GB). | `number` | `512` | no |
| <a name="input_event_source_mapping"></a> [event\_source\_mapping](#input\_event\_source\_mapping) | Map of event source mapping | `any` | `{}` | no |
| <a name="input_file_system_arn"></a> [file\_system\_arn](#input\_file\_system\_arn) | The Amazon Resource Name (ARN) of the Amazon EFS Access Point that provides access to the file system. | `string` | `null` | no |
| <a name="input_file_system_local_mount_path"></a> [file\_system\_local\_mount\_path](#input\_file\_system\_local\_mount\_path) | The path where the function can access the file system, starting with /mnt/. | `string` | `null` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | A unique name for your Lambda Function | `string` | `""` | no |
| <a name="input_function_tags"></a> [function\_tags](#input\_function\_tags) | A map of tags to assign only to the lambda function | `map(string)` | `{}` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Lambda Function entrypoint in your code | `string` | `""` | no |
| <a name="input_hash_extra"></a> [hash\_extra](#input\_hash\_extra) | The string to add into hashing function. Useful when building same source path for different functions. | `string` | `""` | no |
| <a name="input_ignore_source_code_hash"></a> [ignore\_source\_code\_hash](#input\_ignore\_source\_code\_hash) | Whether to ignore changes to the function's source code hash. Set to true if you manage infrastructure and code deployments separately. | `bool` | `false` | no |
| <a name="input_image_config_command"></a> [image\_config\_command](#input\_image\_config\_command) | The CMD for the docker image | `list(string)` | `[]` | no |
| <a name="input_image_config_entry_point"></a> [image\_config\_entry\_point](#input\_image\_config\_entry\_point) | The ENTRYPOINT for the docker image | `list(string)` | `[]` | no |
| <a name="input_image_config_working_directory"></a> [image\_config\_working\_directory](#input\_image\_config\_working\_directory) | The working directory for the docker image | `string` | `null` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | The ECR image URI containing the function's deployment package. | `string` | `null` | no |
| <a name="input_invoke_mode"></a> [invoke\_mode](#input\_invoke\_mode) | Invoke mode of the Lambda Function URL. Valid values are BUFFERED (default) and RESPONSE\_STREAM. | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of KMS key to use by your Lambda Function | `string` | `null` | no |
| <a name="input_lambda_at_edge"></a> [lambda\_at\_edge](#input\_lambda\_at\_edge) | Set this to true if using Lambda@Edge, to enable publishing, limit the timeout, and allow edgelambda.amazonaws.com to invoke the function | `bool` | `false` | no |
| <a name="input_lambda_at_edge_logs_all_regions"></a> [lambda\_at\_edge\_logs\_all\_regions](#input\_lambda\_at\_edge\_logs\_all\_regions) | Whether to specify a wildcard in IAM policy used by Lambda@Edge to allow logging in all regions | `bool` | `true` | no |
| <a name="input_lambda_role"></a> [lambda\_role](#input\_lambda\_role) | IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details. | `string` | `""` | no |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | Name of Lambda Layer to create | `string` | `""` | no |
| <a name="input_layer_skip_destroy"></a> [layer\_skip\_destroy](#input\_layer\_skip\_destroy) | Whether to retain the old version of a previously deployed Lambda Layer. | `bool` | `false` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. | `list(string)` | `null` | no |
| <a name="input_license_info"></a> [license\_info](#input\_license\_info) | License info for your Lambda Layer. Eg, MIT or full url of a license. | `string` | `""` | no |
| <a name="input_local_existing_package"></a> [local\_existing\_package](#input\_local\_existing\_package) | The absolute path to an existing zip-file to use | `string` | `null` | no |
| <a name="input_logging_application_log_level"></a> [logging\_application\_log\_level](#input\_logging\_application\_log\_level) | The application log level of the Lambda Function. Valid values are "TRACE", "DEBUG", "INFO", "WARN", "ERROR", or "FATAL". | `string` | `"INFO"` | no |
| <a name="input_logging_log_format"></a> [logging\_log\_format](#input\_logging\_log\_format) | The log format of the Lambda Function. Valid values are "JSON" or "Text". | `string` | `"Text"` | no |
| <a name="input_logging_log_group"></a> [logging\_log\_group](#input\_logging\_log\_group) | The CloudWatch log group to send logs to. | `string` | `null` | no |
| <a name="input_logging_system_log_level"></a> [logging\_system\_log\_level](#input\_logging\_system\_log\_level) | The system log level of the Lambda Function. Valid values are "DEBUG", "INFO", or "WARN". | `string` | `"INFO"` | no |
| <a name="input_maximum_event_age_in_seconds"></a> [maximum\_event\_age\_in\_seconds](#input\_maximum\_event\_age\_in\_seconds) | Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600. | `number` | `null` | no |
| <a name="input_maximum_retry_attempts"></a> [maximum\_retry\_attempts](#input\_maximum\_retry\_attempts) | Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2. | `number` | `null` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments. | `number` | `128` | no |
| <a name="input_number_of_policies"></a> [number\_of\_policies](#input\_number\_of\_policies) | Number of policies to attach to IAM role for Lambda Function | `number` | `0` | no |
| <a name="input_number_of_policy_jsons"></a> [number\_of\_policy\_jsons](#input\_number\_of\_policy\_jsons) | Number of policies JSON to attach to IAM role for Lambda Function | `number` | `0` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | The Lambda deployment package type. Valid options: Zip or Image | `string` | `"Zip"` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | List of policy statements ARN to attach to Lambda Function role | `list(string)` | `[]` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | An additional policy document ARN to attach to the Lambda Function role | `string` | `null` | no |
| <a name="input_policy_json"></a> [policy\_json](#input\_policy\_json) | An additional policy document as JSON to attach to the Lambda Function role | `string` | `null` | no |
| <a name="input_policy_jsons"></a> [policy\_jsons](#input\_policy\_jsons) | List of additional policy documents as JSON to attach to Lambda Function role | `list(string)` | `[]` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | IAM policy name. It override the default value, which is the same as role\_name | `string` | `null` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path of policies to that should be added to IAM role for Lambda Function | `string` | `null` | no |
| <a name="input_policy_statements"></a> [policy\_statements](#input\_policy\_statements) | Map of dynamic policy statements to attach to Lambda Function role | `any` | `{}` | no |
| <a name="input_provisioned_concurrent_executions"></a> [provisioned\_concurrent\_executions](#input\_provisioned\_concurrent\_executions) | Amount of capacity to allocate. Set to 1 or greater to enable, or set to 0 to disable provisioned concurrency. | `number` | `-1` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version. | `bool` | `false` | no |
| <a name="input_recreate_missing_package"></a> [recreate\_missing\_package](#input\_recreate\_missing\_package) | Whether to recreate missing Lambda package if it is missing locally or not | `bool` | `true` | no |
| <a name="input_replace_security_groups_on_destroy"></a> [replace\_security\_groups\_on\_destroy](#input\_replace\_security\_groups\_on\_destroy) | (Optional) When true, all security groups defined in vpc\_security\_group\_ids will be replaced with the default security group after the function is destroyed. Set the replacement\_security\_group\_ids variable to use a custom list of security groups for replacement instead. | `bool` | `null` | no |
| <a name="input_replacement_security_group_ids"></a> [replacement\_security\_group\_ids](#input\_replacement\_security\_group\_ids) | (Optional) List of security group IDs to assign to orphaned Lambda function network interfaces upon destruction. replace\_security\_groups\_on\_destroy must be set to true to use this attribute. | `list(string)` | `null` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for this Lambda Function. A value of 0 disables Lambda Function from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `number` | `-1` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | Description of IAM role to use for Lambda Function | `string` | `null` | no |
| <a name="input_role_force_detach_policies"></a> [role\_force\_detach\_policies](#input\_role\_force\_detach\_policies) | Specifies to force detaching any policies the IAM role has before destroying it. | `bool` | `true` | no |
| <a name="input_role_maximum_session_duration"></a> [role\_maximum\_session\_duration](#input\_role\_maximum\_session\_duration) | Maximum session duration, in seconds, for the IAM role | `number` | `3600` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role to use for Lambda Function | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role to use for Lambda Function | `string` | `null` | no |
| <a name="input_role_permissions_boundary"></a> [role\_permissions\_boundary](#input\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the IAM role used by Lambda Function | `string` | `null` | no |
| <a name="input_role_tags"></a> [role\_tags](#input\_role\_tags) | A map of tags to assign to IAM role | `map(string)` | `{}` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda Function runtime | `string` | `""` | no |
| <a name="input_s3_acl"></a> [s3\_acl](#input\_s3\_acl) | The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, and bucket-owner-full-control. Defaults to private. | `string` | `"private"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket to store artifacts | `string` | `null` | no |
| <a name="input_s3_existing_package"></a> [s3\_existing\_package](#input\_s3\_existing\_package) | The S3 bucket object with keys bucket, key, version pointing to an existing zip-file to use | `map(string)` | `null` | no |
| <a name="input_s3_kms_key_id"></a> [s3\_kms\_key\_id](#input\_s3\_kms\_key\_id) | Specifies a custom KMS key to use for S3 object encryption. | `string` | `null` | no |
| <a name="input_s3_object_override_default_tags"></a> [s3\_object\_override\_default\_tags](#input\_s3\_object\_override\_default\_tags) | Whether to override the default\_tags from provider? NB: S3 objects support a maximum of 10 tags. | `bool` | `false` | no |
| <a name="input_s3_object_storage_class"></a> [s3\_object\_storage\_class](#input\_s3\_object\_storage\_class) | Specifies the desired Storage Class for the artifact uploaded to S3. Can be either STANDARD, REDUCED\_REDUNDANCY, ONEZONE\_IA, INTELLIGENT\_TIERING, or STANDARD\_IA. | `string` | `"ONEZONE_IA"` | no |
| <a name="input_s3_object_tags"></a> [s3\_object\_tags](#input\_s3\_object\_tags) | A map of tags to assign to S3 bucket object. | `map(string)` | `{}` | no |
| <a name="input_s3_object_tags_only"></a> [s3\_object\_tags\_only](#input\_s3\_object\_tags\_only) | Set to true to not merge tags with s3\_object\_tags. Useful to avoid breaching S3 Object 10 tag limit. | `bool` | `false` | no |
| <a name="input_s3_prefix"></a> [s3\_prefix](#input\_s3\_prefix) | Directory name where artifacts should be stored in the S3 bucket. If unset, the path from `artifacts_dir` is used | `string` | `null` | no |
| <a name="input_s3_server_side_encryption"></a> [s3\_server\_side\_encryption](#input\_s3\_server\_side\_encryption) | Specifies server-side encryption of the object in S3. Valid values are "AES256" and "aws:kms". | `string` | `null` | no |
| <a name="input_snap_start"></a> [snap\_start](#input\_snap\_start) | (Optional) Snap start settings for low-latency startups | `bool` | `false` | no |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | The absolute path to a local file or directory containing your Lambda source code | `any` | `null` | no |
| <a name="input_store_on_s3"></a> [store\_on\_s3](#input\_store\_on\_s3) | Whether to store produced artifacts on S3 or locally. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time your Lambda Function has to run in seconds. | `number` | `3` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Define maximum timeout for creating, updating, and deleting Lambda Function resources | `map(string)` | `{}` | no |
| <a name="input_tracing_mode"></a> [tracing\_mode](#input\_tracing\_mode) | Tracing mode of the Lambda Function. Valid value can be either PassThrough or Active. | `string` | `null` | no |
| <a name="input_trigger_on_package_timestamp"></a> [trigger\_on\_package\_timestamp](#input\_trigger\_on\_package\_timestamp) | Whether to recreate the Lambda package if the timestamp changes | `bool` | `true` | no |
| <a name="input_trusted_entities"></a> [trusted\_entities](#input\_trusted\_entities) | List of additional trusted entities for assuming Lambda Function role (trust relationship) | `any` | `[]` | no |
| <a name="input_use_existing_cloudwatch_log_group"></a> [use\_existing\_cloudwatch\_log\_group](#input\_use\_existing\_cloudwatch\_log\_group) | Whether to use an existing CloudWatch log group or create new | `bool` | `false` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of security group ids when Lambda Function should run in the VPC. | `list(string)` | `null` | no |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets. | `list(string)` | `null` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
