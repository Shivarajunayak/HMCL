# iot

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
    	 vpc_id  = 
  
	 # Optional variables
  	 alarm_actions  = []
  	 alarm_cpu_threshold_percent  = 75
  	 alarm_memory_threshold_bytes  = 10000000
  	 apply_immediately  = true
  	 at_rest_encryption_enabled  = false
  	 auth_token  = null
  	 auto_minor_version_upgrade  = null
  	 automatic_failover_enabled  = false
  	 availability_zones  = []
  	 cloudwatch_metric_alarms_enabled  = false
  	 cluster_mode_enabled  = false
  	 cluster_mode_num_node_groups  = 0
  	 cluster_mode_replicas_per_node_group  = 0
  	 cluster_size  = 1
  	 create  = false
  	 create_parameter_group  = true
  	 data_tiering_enabled  = false
  	 description  = null
  	 dns_subdomain  = ""
  	 elasticache_subnet_group_name  = ""
  	 engine_version  = "4.0.10"
  	 family  = "redis4.0"
  	 final_snapshot_identifier  = null
  	 instance_type  = "cache.t2.micro"
  	 kms_key_id  = null
  	 log_delivery_configuration  = []
  	 maintenance_window  = "wed:03:00-wed:04:00"
  	 multi_az_enabled  = false
  	 notification_topic_arn  = ""
  	 ok_actions  = []
  	 parameter  = []
  	 parameter_group_description  = null
  	 parameter_group_name  = null
  	 port  = 6379
  	 replication_group_id  = ""
  	 security_group_ids  = null
  	 snapshot_arns  = []
  	 snapshot_name  = null
  	 snapshot_retention_limit  = 0
  	 snapshot_window  = "06:30-07:30"
  	 subnets  = []
  	 tags  = {}
  	 transit_encryption_enabled  = true
  	 user_group_ids  = null
  	 zone_id  = []
}
```
## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cache_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cache_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_elasticache_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | Alarm action list | `list(string)` | `[]` | no |
| <a name="input_alarm_cpu_threshold_percent"></a> [alarm\_cpu\_threshold\_percent](#input\_alarm\_cpu\_threshold\_percent) | CPU threshold alarm level | `number` | `75` | no |
| <a name="input_alarm_memory_threshold_bytes"></a> [alarm\_memory\_threshold\_bytes](#input\_alarm\_memory\_threshold\_bytes) | Ram threshold alarm level | `number` | `10000000` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Apply changes immediately | `bool` | `true` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Enable encryption at rest | `bool` | `false` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | Auth token for password protecting redis, `transit_encryption_enabled` must be set to `true`. Password must be longer than 16 chars | `string` | `null` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported if the engine version is 6 or higher. | `bool` | `null` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Automatic failover (Not available for T1/T2 instances) | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zone IDs | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_metric_alarms_enabled"></a> [cloudwatch\_metric\_alarms\_enabled](#input\_cloudwatch\_metric\_alarms\_enabled) | Boolean flag to enable/disable CloudWatch metrics alarms | `bool` | `false` | no |
| <a name="input_cluster_mode_enabled"></a> [cluster\_mode\_enabled](#input\_cluster\_mode\_enabled) | Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed | `bool` | `false` | no |
| <a name="input_cluster_mode_num_node_groups"></a> [cluster\_mode\_num\_node\_groups](#input\_cluster\_mode\_num\_node\_groups) | Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications | `number` | `0` | no |
| <a name="input_cluster_mode_replicas_per_node_group"></a> [cluster\_mode\_replicas\_per\_node\_group](#input\_cluster\_mode\_replicas\_per\_node\_group) | Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource | `number` | `0` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of nodes in cluster. *Ignored when `cluster_mode_enabled` == `true`* | `number` | `1` | no |
| <a name="input_create"></a> [create](#input\_create) | Create Elasticache redis cluster | `bool` | `false` | no |
| <a name="input_create_parameter_group"></a> [create\_parameter\_group](#input\_create\_parameter\_group) | Whether new parameter group should be created. Set to false if you want to use existing parameter group | `bool` | `true` | no |
| <a name="input_data_tiering_enabled"></a> [data\_tiering\_enabled](#input\_data\_tiering\_enabled) | Enables data tiering. Data tiering is only supported for replication groups using the r6gd node type. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of elasticache replication group | `string` | `null` | no |
| <a name="input_dns_subdomain"></a> [dns\_subdomain](#input\_dns\_subdomain) | The subdomain to use for the CNAME record. If not provided then the CNAME record will use var.name. | `string` | `""` | no |
| <a name="input_elasticache_subnet_group_name"></a> [elasticache\_subnet\_group\_name](#input\_elasticache\_subnet\_group\_name) | Subnet group name for the ElastiCache instance | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Redis engine version | `string` | `"4.0.10"` | no |
| <a name="input_family"></a> [family](#input\_family) | Redis family | `string` | `"redis4.0"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster. If omitted, no final snapshot will be made. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Elastic cache instance type | `string` | `"cache.t2.micro"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. `at_rest_encryption_enabled` must be set to `true` | `string` | `null` | no |
| <a name="input_log_delivery_configuration"></a> [log\_delivery\_configuration](#input\_log\_delivery\_configuration) | The log\_delivery\_configuration block allows the streaming of Redis SLOWLOG or Redis Engine Log to CloudWatch Logs or Kinesis Data Firehose. Max of 2 blocks. | `list(map(any))` | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Maintenance window | `string` | `"wed:03:00-wed:04:00"` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | Multi AZ (Automatic Failover must also be enabled.  If Cluster Mode is enabled, Multi AZ is on by default, and this setting is ignored) | `bool` | `false` | no |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | Notification topic arn | `string` | `""` | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN) | `list(string)` | `[]` | no |
| <a name="input_parameter"></a> [parameter](#input\_parameter) | A list of Redis parameters to apply. Note that parameters may differ from one Redis family to another | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_parameter_group_description"></a> [parameter\_group\_description](#input\_parameter\_group\_description) | Managed by Terraform | `string` | `null` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | Override the default parameter group name | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Redis port | `number` | `6379` | no |
| <a name="input_replication_group_id"></a> [replication\_group\_id](#input\_replication\_group\_id) | Replication group ID with the following constraints: <br>A name must contain from 1 to 20 alphanumeric characters or hyphens. <br> The first character must be a letter. <br> A name cannot end with a hyphen or contain two consecutive hyphens. | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security Group IDs to associate with the replication group | `list(string)` | `null` | no |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input\_snapshot\_arns) | A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my\_bucket/snapshot1.rdb | `list(string)` | `[]` | no |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input\_snapshot\_name) | The name of a snapshot from which to restore data into the new node group. Changing the snapshot\_name forces a new resource. | `string` | `null` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | `number` | `0` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. | `string` | `"06:30-07:30"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to resources. | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Set `true` to enable encryption in transit. Forced `true` if `var.auth_token` is set.<br>If this is enabled, use the [following guide](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html#connect-tls) to access redis. | `bool` | `true` | no |
| <a name="input_user_group_ids"></a> [user\_group\_ids](#input\_user\_group\_ids) | User Group ID to associate with the replication group | `list(string)` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 DNS Zone ID as list of string (0 or 1 items). If empty, no custom DNS name will be published.<br>If the list contains a single Zone ID, a custom DNS name will be pulished in that zone.<br>Can also be a plain string, but that use is DEPRECATED because of Terraform issues. | `any` | `[]` | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
