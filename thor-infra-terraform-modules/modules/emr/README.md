# emr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-emr/README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.44 |
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
  	 source  = "<module-path>"
  
	 # Optional variables
  	 additional_info  = null
  	 applications  = []
  	 auto_termination_policy  = {}
  	 autoscaling_iam_role_arn  = null
  	 autoscaling_iam_role_description  = null
  	 autoscaling_iam_role_name  = null
  	 bootstrap_action  = {}
  	 configurations  = null
  	 configurations_json  = null
  	 core_instance_fleet  = {}
  	 core_instance_group  = {}
  	 create  = true
  	 create_autoscaling_iam_role  = true
  	 create_iam_instance_profile  = true
  	 create_managed_security_groups  = true
  	 create_security_configuration  = true
  	 create_service_iam_role  = true
  	 custom_ami_id  = null
  	 ebs_root_volume_size  = null
  	 ec2_attributes  = {}
  	 iam_instance_profile_description  = null
  	 iam_instance_profile_name  = null
  	 iam_instance_profile_policies  = {
  "AmazonElasticMapReduceforEC2Role": "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}
  	 iam_role_path  = null
  	 iam_role_permissions_boundary  = null
  	 iam_role_tags  = {}
  	 iam_role_use_name_prefix  = true
  	 is_private_cluster  = true
  	 keep_job_flow_alive_when_no_steps  = null
  	 kerberos_attributes  = {}
  	 list_steps_states  = []
  	 log_encryption_kms_key_id  = null
  	 log_uri  = null
  	 managed_scaling_policy  = {}
  	 managed_security_group_name  = null
  	 managed_security_group_tags  = {}
  	 managed_security_group_use_name_prefix  = true
  	 master_instance_fleet  = {}
  	 master_instance_group  = {}
  	 master_security_group_description  = "Managed master security group"
  	 master_security_group_rules  = {
  "default": {
    "cidr_blocks": [
      "0.0.0.0/0"
    ],
    "description": "Allow all egress traffic",
    "from_port": 0,
    "ipv6_cidr_blocks": [
      "::/0"
    ],
    "protocol": "-1",
    "to_port": 0,
    "type": "egress"
  }
}
  	 name  = ""
  	 placement_group_config  = {}
  	 release_label  = null
  	 release_label_filters  = {
  "default": {
    "prefix": "emr-6"
  }
}
  	 scale_down_behavior  = "TERMINATE_AT_TASK_COMPLETION"
  	 security_configuration  = ""
  	 security_configuration_name  = null
  	 security_configuration_use_name_prefix  = true
  	 service_iam_role_arn  = null
  	 service_iam_role_description  = null
  	 service_iam_role_name  = null
  	 service_iam_role_policies  = {
  "AmazonEMRServicePolicy_v2": "arn:aws:iam::aws:policy/service-role/AmazonEMRServicePolicy_v2"
}
  	 service_pass_role_policy_description  = null
  	 service_pass_role_policy_name  = null
  	 service_security_group_description  = "Managed service access security group"
  	 service_security_group_rules  = {}
  	 slave_security_group_description  = "Managed slave security group"
  	 slave_security_group_rules  = {
  "default": {
    "cidr_blocks": [
      "0.0.0.0/0"
    ],
    "description": "Allow all egress traffic",
    "from_port": 0,
    "ipv6_cidr_blocks": [
      "::/0"
    ],
    "protocol": "-1",
    "to_port": 0,
    "type": "egress"
  }
}
  	 step  = {}
  	 step_concurrency_level  = null
  	 tags  = {}
  	 task_instance_fleet  = {}
  	 task_instance_group  = {}
  	 termination_protection  = null
  	 unhealthy_node_replacement  = null
  	 visible_to_all_users  = null
  	 vpc_id  = ""
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_info"></a> [additional\_info](#input\_additional\_info) | JSON string for selecting additional features such as adding proxy information. Note: Currently there is no API to retrieve the value of this argument after EMR cluster creation from provider, therefore Terraform cannot detect drift from the actual EMR cluster if its value is changed outside Terraform | `string` | `null` | no |
| <a name="input_applications"></a> [applications](#input\_applications) | A case-insensitive list of applications for Amazon EMR to install and configure when launching the cluster | `list(string)` | `[]` | no |
| <a name="input_auto_termination_policy"></a> [auto\_termination\_policy](#input\_auto\_termination\_policy) | An auto-termination policy for an Amazon EMR cluster. An auto-termination policy defines the amount of idle time in seconds after which a cluster automatically terminates | `any` | `{}` | no |
| <a name="input_autoscaling_iam_role_arn"></a> [autoscaling\_iam\_role\_arn](#input\_autoscaling\_iam\_role\_arn) | The ARN of an existing IAM role to use for autoscaling | `string` | `null` | no |
| <a name="input_autoscaling_iam_role_description"></a> [autoscaling\_iam\_role\_description](#input\_autoscaling\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_autoscaling_iam_role_name"></a> [autoscaling\_iam\_role\_name](#input\_autoscaling\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_bootstrap_action"></a> [bootstrap\_action](#input\_bootstrap\_action) | Ordered list of bootstrap actions that will be run before Hadoop is started on the cluster nodes | `any` | `{}` | no |
| <a name="input_configurations"></a> [configurations](#input\_configurations) | List of configurations supplied for the EMR cluster you are creating. Supply a configuration object for applications to override their default configuration | `string` | `null` | no |
| <a name="input_configurations_json"></a> [configurations\_json](#input\_configurations\_json) | JSON string for supplying list of configurations for the EMR cluster | `string` | `null` | no |
| <a name="input_core_instance_fleet"></a> [core\_instance\_fleet](#input\_core\_instance\_fleet) | Configuration block to use an [Instance Fleet](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-instance-fleet.html) for the core node type. Cannot be specified if any `core_instance_group` configuration blocks are set | `any` | `{}` | no |
| <a name="input_core_instance_group"></a> [core\_instance\_group](#input\_core\_instance\_group) | Configuration block to use an [Instance Group] for the core node type | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_create_autoscaling_iam_role"></a> [create\_autoscaling\_iam\_role](#input\_create\_autoscaling\_iam\_role) | Determines whether the autoscaling IAM role should be created | `bool` | `true` | no |
| <a name="input_create_iam_instance_profile"></a> [create\_iam\_instance\_profile](#input\_create\_iam\_instance\_profile) | Determines whether the EC2 IAM role/instance profile should be created | `bool` | `true` | no |
| <a name="input_create_managed_security_groups"></a> [create\_managed\_security\_groups](#input\_create\_managed\_security\_groups) | Determines whether managed security groups are created | `bool` | `true` | no |
| <a name="input_create_security_configuration"></a> [create\_security\_configuration](#input\_create\_security\_configuration) | Determines whether a security configuration is created | `bool` | `true` | no |
| <a name="input_create_service_iam_role"></a> [create\_service\_iam\_role](#input\_create\_service\_iam\_role) | Determines whether the service IAM role should be created | `bool` | `true` | no |
| <a name="input_custom_ami_id"></a> [custom\_ami\_id](#input\_custom\_ami\_id) | Custom Amazon Linux AMI for the cluster (instead of an EMR-owned AMI). Available in Amazon EMR version 5.7.0 and later | `string` | `null` | no |
| <a name="input_ebs_root_volume_size"></a> [ebs\_root\_volume\_size](#input\_ebs\_root\_volume\_size) | Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later | `number` | `null` | no |
| <a name="input_ec2_attributes"></a> [ec2\_attributes](#input\_ec2\_attributes) | Attributes for the EC2 instances running the job flow | `any` | `{}` | no |
| <a name="input_iam_instance_profile_description"></a> [iam\_instance\_profile\_description](#input\_iam\_instance\_profile\_description) | Description of the EC2 IAM role/instance profile | `string` | `null` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | Name to use on EC2 IAM role/instance profile created | `string` | `null` | no |
| <a name="input_iam_instance_profile_policies"></a> [iam\_instance\_profile\_policies](#input\_iam\_instance\_profile\_policies) | Map of IAM policies to attach to the EC2 IAM role/instance profile | `map(string)` | <pre>{<br>  "AmazonElasticMapReduceforEC2Role": "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"<br>}</pre> | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | IAM role path | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | A map of additional tags to add to the IAM role created | `map(string)` | `{}` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Determines whether the IAM role name is used as a prefix | `bool` | `true` | no |
| <a name="input_is_private_cluster"></a> [is\_private\_cluster](#input\_is\_private\_cluster) | Identifies whether the cluster is created in a private subnet | `bool` | `true` | no |
| <a name="input_keep_job_flow_alive_when_no_steps"></a> [keep\_job\_flow\_alive\_when\_no\_steps](#input\_keep\_job\_flow\_alive\_when\_no\_steps) | Switch on/off run cluster with no steps or when all steps are complete (default is on) | `bool` | `null` | no |
| <a name="input_kerberos_attributes"></a> [kerberos\_attributes](#input\_kerberos\_attributes) | Kerberos configuration for the cluster | `any` | `{}` | no |
| <a name="input_list_steps_states"></a> [list\_steps\_states](#input\_list\_steps\_states) | List of [step states](https://docs.aws.amazon.com/emr/latest/APIReference/API_StepStatus.html) used to filter returned steps | `list(string)` | `[]` | no |
| <a name="input_log_encryption_kms_key_id"></a> [log\_encryption\_kms\_key\_id](#input\_log\_encryption\_kms\_key\_id) | AWS KMS customer master key (CMK) key ID or arn used for encrypting log files. This attribute is only available with EMR version 5.30.0 and later, excluding EMR 6.0.0 | `string` | `null` | no |
| <a name="input_log_uri"></a> [log\_uri](#input\_log\_uri) | S3 bucket to write the log files of the job flow. If a value is not provided, logs are not created | `string` | `null` | no |
| <a name="input_managed_scaling_policy"></a> [managed\_scaling\_policy](#input\_managed\_scaling\_policy) | Compute limit configuration for a [Managed Scaling Policy](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-scaling.html) | `any` | `{}` | no |
| <a name="input_managed_security_group_name"></a> [managed\_security\_group\_name](#input\_managed\_security\_group\_name) | Name to use on manged security group created. Note - `-master`, `-slave`, and `-service` will be appended to this name to distinguish | `string` | `null` | no |
| <a name="input_managed_security_group_tags"></a> [managed\_security\_group\_tags](#input\_managed\_security\_group\_tags) | A map of additional tags to add to the security group created | `map(string)` | `{}` | no |
| <a name="input_managed_security_group_use_name_prefix"></a> [managed\_security\_group\_use\_name\_prefix](#input\_managed\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`security_group_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_master_instance_fleet"></a> [master\_instance\_fleet](#input\_master\_instance\_fleet) | Configuration block to use an [Instance Fleet](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-instance-fleet.html) for the master node type. Cannot be specified if any `master_instance_group` configuration blocks are set | `any` | `{}` | no |
| <a name="input_master_instance_group"></a> [master\_instance\_group](#input\_master\_instance\_group) | Configuration block to use an [Instance Group](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-instance-group-configuration.html#emr-plan-instance-groups) for the [master node type](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-master-core-task-nodes.html#emr-plan-master) | `any` | `{}` | no |
| <a name="input_master_security_group_description"></a> [master\_security\_group\_description](#input\_master\_security\_group\_description) | Description of the security group created | `string` | `"Managed master security group"` | no |
| <a name="input_master_security_group_rules"></a> [master\_security\_group\_rules](#input\_master\_security\_group\_rules) | Security group rules to add to the security group created | `any` | <pre>{<br>  "default": {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow all egress traffic",<br>    "from_port": 0,<br>    "ipv6_cidr_blocks": [<br>      "::/0"<br>    ],<br>    "protocol": "-1",<br>    "to_port": 0,<br>    "type": "egress"<br>  }<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the job flow | `string` | `""` | no |
| <a name="input_placement_group_config"></a> [placement\_group\_config](#input\_placement\_group\_config) | The specified placement group configuration | `any` | `{}` | no |
| <a name="input_release_label"></a> [release\_label](#input\_release\_label) | Release label for the Amazon EMR release | `string` | `null` | no |
| <a name="input_release_label_filters"></a> [release\_label\_filters](#input\_release\_label\_filters) | Map of release label filters use to lookup a release label | `any` | <pre>{<br>  "default": {<br>    "prefix": "emr-6"<br>  }<br>}</pre> | no |
| <a name="input_scale_down_behavior"></a> [scale\_down\_behavior](#input\_scale\_down\_behavior) | Way that individual Amazon EC2 instances terminate when an automatic scale-in activity occurs or an instance group is resized | `string` | `"TERMINATE_AT_TASK_COMPLETION"` | no |
| <a name="input_security_configuration"></a> [security\_configuration](#input\_security\_configuration) | EMR Security Configuration JSON | `string` | `""` | no |
| <a name="input_security_configuration_name"></a> [security\_configuration\_name](#input\_security\_configuration\_name) | Name of the security configuration to create, or attach if `create_security_configuration` is `false`. Only valid for EMR clusters with `release_label` 4.8.0 or greater | `string` | `null` | no |
| <a name="input_security_configuration_use_name_prefix"></a> [security\_configuration\_use\_name\_prefix](#input\_security\_configuration\_use\_name\_prefix) | Determines whether `security_configuration_name` is used as a prefix | `bool` | `true` | no |
| <a name="input_service_iam_role_arn"></a> [service\_iam\_role\_arn](#input\_service\_iam\_role\_arn) | The ARN of an existing IAM role to use for the service | `string` | `null` | no |
| <a name="input_service_iam_role_description"></a> [service\_iam\_role\_description](#input\_service\_iam\_role\_description) | Description of the role | `string` | `null` | no |
| <a name="input_service_iam_role_name"></a> [service\_iam\_role\_name](#input\_service\_iam\_role\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_service_iam_role_policies"></a> [service\_iam\_role\_policies](#input\_service\_iam\_role\_policies) | Map of IAM policies to attach to the service role | `map(string)` | <pre>{<br>  "AmazonEMRServicePolicy_v2": "arn:aws:iam::aws:policy/service-role/AmazonEMRServicePolicy_v2"<br>}</pre> | no |
| <a name="input_service_pass_role_policy_description"></a> [service\_pass\_role\_policy\_description](#input\_service\_pass\_role\_policy\_description) | Description of the policy | `string` | `null` | no |
| <a name="input_service_pass_role_policy_name"></a> [service\_pass\_role\_policy\_name](#input\_service\_pass\_role\_policy\_name) | Name to use on IAM policy created | `string` | `null` | no |
| <a name="input_service_security_group_description"></a> [service\_security\_group\_description](#input\_service\_security\_group\_description) | Description of the security group created | `string` | `"Managed service access security group"` | no |
| <a name="input_service_security_group_rules"></a> [service\_security\_group\_rules](#input\_service\_security\_group\_rules) | Security group rules to add to the security group created | `any` | `{}` | no |
| <a name="input_slave_security_group_description"></a> [slave\_security\_group\_description](#input\_slave\_security\_group\_description) | Description of the security group created | `string` | `"Managed slave security group"` | no |
| <a name="input_slave_security_group_rules"></a> [slave\_security\_group\_rules](#input\_slave\_security\_group\_rules) | Security group rules to add to the security group created | `any` | <pre>{<br>  "default": {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "Allow all egress traffic",<br>    "from_port": 0,<br>    "ipv6_cidr_blocks": [<br>      "::/0"<br>    ],<br>    "protocol": "-1",<br>    "to_port": 0,<br>    "type": "egress"<br>  }<br>}</pre> | no |
| <a name="input_step"></a> [step](#input\_step) | Steps to run when creating the cluster | `any` | `{}` | no |
| <a name="input_step_concurrency_level"></a> [step\_concurrency\_level](#input\_step\_concurrency\_level) | Number of steps that can be executed concurrently. You can specify a maximum of 256 steps. Only valid for EMR clusters with `release_label` 5.28.0 or greater (default is 1) | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_task_instance_fleet"></a> [task\_instance\_fleet](#input\_task\_instance\_fleet) | Configuration block to use an [Instance Fleet](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-instance-fleet.html) for the task node type. Cannot be specified if any `task_instance_group` configuration blocks are set | `any` | `{}` | no |
| <a name="input_task_instance_group"></a> [task\_instance\_group](#input\_task\_instance\_group) | Configuration block to use an [Instance Group](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-instance-group-configuration.html#emr-plan-instance-groups) for the [task node type](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-master-core-task-nodes.html#emr-plan-master) | `any` | `{}` | no |
| <a name="input_termination_protection"></a> [termination\_protection](#input\_termination\_protection) | Switch on/off termination protection (default is `false`, except when using multiple master nodes). Before attempting to destroy the resource when termination protection is enabled, this configuration must be applied with its value set to `false` | `bool` | `null` | no |
| <a name="input_unhealthy_node_replacement"></a> [unhealthy\_node\_replacement](#input\_unhealthy\_node\_replacement) | Whether whether Amazon EMR should gracefully replace core nodes that have degraded within the cluster. Default value is `false` | `bool` | `null` | no |
| <a name="input_visible_to_all_users"></a> [visible\_to\_all\_users](#input\_visible\_to\_all\_users) | Whether the job flow is visible to all IAM users of the AWS account associated with the job flow. Default value is `true` | `bool` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the Amazon Virtual Private Cloud (Amazon VPC) where the security groups will be created | `string` | `""` | no |
## Outputs

No outputs.
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
