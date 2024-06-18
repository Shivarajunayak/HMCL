# msk

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-msk/README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.21 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Optional variables
  	 broker_node_az_distribution  = null
  	 broker_node_client_subnets  = [
  "subnet-0fe951b96f66b6b5e",
  "subnet-018d83867993c1abf"
]
  	 broker_node_connectivity_info  = {}
  	 broker_node_instance_type  = "kafka.t3.small"
  	 broker_node_security_groups  = [
  "sg-0ab40fb95c00881c3"
]
  	 broker_node_storage_info  = {}
  	 client_authentication  = {}
  	 cloudwatch_log_group_kms_key_id  = null
  	 cloudwatch_log_group_name  = null
  	 cloudwatch_log_group_retention_in_days  = 0
  	 cloudwatch_logs_enabled  = false
  	 cluster_override_policy_documents  = null
  	 cluster_policy_statements  = null
  	 cluster_source_policy_documents  = null
  	 configuration_arn  = null
  	 configuration_description  = "My Kafka cluster configuration"
  	 configuration_name  = "my-kafka-config"
  	 configuration_revision  = null
  	 configuration_server_properties  = {}
  	 connect_custom_plugin_timeouts  = {
  "create": null
}
  	 connect_custom_plugins  = {}
  	 connect_worker_config_description  = null
  	 connect_worker_config_name  = null
  	 connect_worker_config_properties_file_content  = null
  	 create  = true
  	 create_cloudwatch_log_group  = true
  	 create_cluster_policy  = false
  	 create_configuration  = true
  	 create_connect_worker_configuration  = false
  	 create_schema_registry  = true
  	 create_scram_secret_association  = true
  	 enable_storage_autoscaling  = true
  	 encryption_at_rest_kms_key_arn  = null
  	 encryption_in_transit_client_broker  = "TLS"
  	 encryption_in_transit_in_cluster  = true
  	 enhanced_monitoring  = null
  	 firehose_delivery_stream  = null
  	 firehose_logs_enabled  = false
  	 jmx_exporter_enabled  = false
  	 kafka_version  = "3.5.1"
  	 name  = "msk"
  	 node_exporter_enabled  = false
  	 number_of_broker_nodes  = "2"
  	 s3_logs_bucket  = null
  	 s3_logs_enabled  = false
  	 s3_logs_prefix  = null
  	 scaling_max_capacity  = 250
  	 scaling_role_arn  = "arn:aws:iam::637423293078:role/aws-service-role/kafka.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_KafkaCluster"
  	 scaling_target_value  = 70
  	 schema_registries  = {}
  	 schemas  = {}
  	 scram_secret_association_secret_arn_list  = []
  	 storage_mode  = null
  	 tags  = {}
  	 timeouts  = {}
  	 vpc_connections  = {}
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_broker_node_az_distribution"></a> [broker\_node\_az\_distribution](#input\_broker\_node\_az\_distribution) | The distribution of broker nodes across availability zones ([documentation](https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html#clusters-model-brokerazdistribution)). Currently the only valid value is `DEFAULT` | `string` | `null` | no |
| <a name="input_broker_node_client_subnets"></a> [broker\_node\_client\_subnets](#input\_broker\_node\_client\_subnets) | A list of subnets to connect to in the client VPC (documentation: https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html#clusters-prop-brokernodegroupinfo-clientsubnets) | `list(string)` | <pre>[<br>  "subnet-0fe951b96f66b6b5e",<br>  "subnet-018d83867993c1abf"<br>]</pre> | no |
| <a name="input_broker_node_connectivity_info"></a> [broker\_node\_connectivity\_info](#input\_broker\_node\_connectivity\_info) | Information about the cluster access configuration | `any` | `{}` | no |
| <a name="input_broker_node_instance_type"></a> [broker\_node\_instance\_type](#input\_broker\_node\_instance\_type) | Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large. ([Pricing info](https://aws.amazon.com/msk/pricing/)) | `string` | `"kafka.t3.small"` | no |
| <a name="input_broker_node_security_groups"></a> [broker\_node\_security\_groups](#input\_broker\_node\_security\_groups) | A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster | `list(string)` | <pre>[<br>  "sg-0ab40fb95c00881c3"<br>]</pre> | no |
| <a name="input_broker_node_storage_info"></a> [broker\_node\_storage\_info](#input\_broker\_node\_storage\_info) | A block that contains information about storage volumes attached to MSK broker nodes | `any` | `{}` | no |
| <a name="input_client_authentication"></a> [client\_authentication](#input\_client\_authentication) | Configuration block for specifying client authentication | `any` | `{}` | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#input\_cloudwatch\_log\_group\_name) | Name of the Cloudwatch Log Group to deliver logs to | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Specifies the number of days you want to retain log events in the log group | `number` | `0` | no |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs | `bool` | `false` | no |
| <a name="input_cluster_override_policy_documents"></a> [cluster\_override\_policy\_documents](#input\_cluster\_override\_policy\_documents) | Override policy documents for cluster policy | `list(string)` | `null` | no |
| <a name="input_cluster_policy_statements"></a> [cluster\_policy\_statements](#input\_cluster\_policy\_statements) | Map of policy statements for cluster policy | `any` | `null` | no |
| <a name="input_cluster_source_policy_documents"></a> [cluster\_source\_policy\_documents](#input\_cluster\_source\_policy\_documents) | Source policy documents for cluster policy | `list(string)` | `null` | no |
| <a name="input_configuration_arn"></a> [configuration\_arn](#input\_configuration\_arn) | ARN of an externally created configuration to use | `string` | `null` | no |
| <a name="input_configuration_description"></a> [configuration\_description](#input\_configuration\_description) | Description of the configuration | `string` | `"My Kafka cluster configuration"` | no |
| <a name="input_configuration_name"></a> [configuration\_name](#input\_configuration\_name) | Name of the configuration | `string` | `"my-kafka-config"` | no |
| <a name="input_configuration_revision"></a> [configuration\_revision](#input\_configuration\_revision) | Revision of the externally created configuration to use | `number` | `null` | no |
| <a name="input_configuration_server_properties"></a> [configuration\_server\_properties](#input\_configuration\_server\_properties) | Contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html) | `map(string)` | `{}` | no |
| <a name="input_connect_custom_plugin_timeouts"></a> [connect\_custom\_plugin\_timeouts](#input\_connect\_custom\_plugin\_timeouts) | Timeout configurations for the connect custom plugins | `map(string)` | <pre>{<br>  "create": null<br>}</pre> | no |
| <a name="input_connect_custom_plugins"></a> [connect\_custom\_plugins](#input\_connect\_custom\_plugins) | Map of custom plugin configuration details (map of maps) | `any` | `{}` | no |
| <a name="input_connect_worker_config_description"></a> [connect\_worker\_config\_description](#input\_connect\_worker\_config\_description) | A summary description of the worker configuration | `string` | `null` | no |
| <a name="input_connect_worker_config_name"></a> [connect\_worker\_config\_name](#input\_connect\_worker\_config\_name) | The name of the worker configuration | `string` | `null` | no |
| <a name="input_connect_worker_config_properties_file_content"></a> [connect\_worker\_config\_properties\_file\_content](#input\_connect\_worker\_config\_properties\_file\_content) | Contents of connect-distributed.properties file. The value can be either base64 encoded or in raw format | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Determines whether cluster resources will be created | `bool` | `true` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether to create a CloudWatch log group | `bool` | `true` | no |
| <a name="input_create_cluster_policy"></a> [create\_cluster\_policy](#input\_create\_cluster\_policy) | Determines whether to create an MSK cluster policy | `bool` | `false` | no |
| <a name="input_create_configuration"></a> [create\_configuration](#input\_create\_configuration) | Determines whether to create a configuration | `bool` | `true` | no |
| <a name="input_create_connect_worker_configuration"></a> [create\_connect\_worker\_configuration](#input\_create\_connect\_worker\_configuration) | Determines whether to create connect worker configuration | `bool` | `false` | no |
| <a name="input_create_schema_registry"></a> [create\_schema\_registry](#input\_create\_schema\_registry) | Determines whether to create a Glue schema registry for managing Avro schemas for the cluster | `bool` | `true` | no |
| <a name="input_create_scram_secret_association"></a> [create\_scram\_secret\_association](#input\_create\_scram\_secret\_association) | Determines whether to create SASL/SCRAM secret association | `bool` | `true` | no |
| <a name="input_enable_storage_autoscaling"></a> [enable\_storage\_autoscaling](#input\_enable\_storage\_autoscaling) | Determines whether autoscaling is enabled for storage | `bool` | `true` | no |
| <a name="input_encryption_at_rest_kms_key_arn"></a> [encryption\_at\_rest\_kms\_key\_arn](#input\_encryption\_at\_rest\_kms\_key\_arn) | You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest | `string` | `null` | no |
| <a name="input_encryption_in_transit_client_broker"></a> [encryption\_in\_transit\_client\_broker](#input\_encryption\_in\_transit\_client\_broker) | Encryption setting for data in transit between clients and brokers. Valid values: `TLS`, `TLS_PLAINTEXT`, and `PLAINTEXT`. Default value is `TLS` | `string` | `"TLS"` | no |
| <a name="input_encryption_in_transit_in_cluster"></a> [encryption\_in\_transit\_in\_cluster](#input\_encryption\_in\_transit\_in\_cluster) | Whether data communication among broker nodes is encrypted. Default value: `true` | `bool` | `true` | no |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input\_enhanced\_monitoring) | Specify the desired enhanced MSK CloudWatch monitoring level. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html) | `string` | `null` | no |
| <a name="input_firehose_delivery_stream"></a> [firehose\_delivery\_stream](#input\_firehose\_delivery\_stream) | Name of the Kinesis Data Firehose delivery stream to deliver logs to | `string` | `null` | no |
| <a name="input_firehose_logs_enabled"></a> [firehose\_logs\_enabled](#input\_firehose\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose | `bool` | `false` | no |
| <a name="input_jmx_exporter_enabled"></a> [jmx\_exporter\_enabled](#input\_jmx\_exporter\_enabled) | Indicates whether you want to enable or disable the JMX Exporter | `bool` | `false` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Specify the desired Kafka software version | `string` | `"3.5.1"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the MSK cluster | `string` | `"msk"` | no |
| <a name="input_node_exporter_enabled"></a> [node\_exporter\_enabled](#input\_node\_exporter\_enabled) | Indicates whether you want to enable or disable the Node Exporter | `bool` | `false` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets | `number` | `"2"` | no |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input\_s3\_logs\_bucket) | Name of the S3 bucket to deliver logs to | `string` | `null` | no |
| <a name="input_s3_logs_enabled"></a> [s3\_logs\_enabled](#input\_s3\_logs\_enabled) | Indicates whether you want to enable or disable streaming broker logs to S3 | `bool` | `false` | no |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input\_s3\_logs\_prefix) | Prefix to append to the folder name | `string` | `null` | no |
| <a name="input_scaling_max_capacity"></a> [scaling\_max\_capacity](#input\_scaling\_max\_capacity) | Max storage capacity for Kafka broker autoscaling | `number` | `250` | no |
| <a name="input_scaling_role_arn"></a> [scaling\_role\_arn](#input\_scaling\_role\_arn) | The ARN of the IAM role that allows Application AutoScaling to modify your scalable target on your behalf. This defaults to an IAM Service-Linked Role | `string` | `"arn:aws:iam::637423293078:role/aws-service-role/kafka.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_KafkaCluster"` | no |
| <a name="input_scaling_target_value"></a> [scaling\_target\_value](#input\_scaling\_target\_value) | The Kafka broker storage utilization at which scaling is initiated | `number` | `70` | no |
| <a name="input_schema_registries"></a> [schema\_registries](#input\_schema\_registries) | A map of schema registries to be created | `map(any)` | `{}` | no |
| <a name="input_schemas"></a> [schemas](#input\_schemas) | A map schemas to be created within the schema registry | `map(any)` | `{}` | no |
| <a name="input_scram_secret_association_secret_arn_list"></a> [scram\_secret\_association\_secret\_arn\_list](#input\_scram\_secret\_association\_secret\_arn\_list) | List of AWS Secrets Manager secret ARNs to associate with SCRAM | `list(string)` | `[]` | no |
| <a name="input_storage_mode"></a> [storage\_mode](#input\_storage\_mode) | Controls storage mode for supported storage tiers. Valid values are: `LOCAL` or `TIERED` | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources created | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configurations for the cluster | `map(string)` | `{}` | no |
| <a name="input_vpc_connections"></a> [vpc\_connections](#input\_vpc\_connections) | Map of VPC Connections to create | `any` | `{}` | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
