# s3

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
aws-s3/README.md updated successfully
sample-lambda-zip/README.md updated successfully
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
  	 acceleration_status  = null
  	 access_log_delivery_policy_source_accounts  = []
  	 access_log_delivery_policy_source_buckets  = []
  	 acl  = null
  	 allowed_kms_key_arn  = null
  	 analytics_configuration  = {}
  	 analytics_self_source_destination  = false
  	 analytics_source_account_id  = null
  	 analytics_source_bucket_arn  = null
  	 attach_access_log_delivery_policy  = false
  	 attach_analytics_destination_policy  = false
  	 attach_deny_incorrect_encryption_headers  = false
  	 attach_deny_incorrect_kms_key_sse  = false
  	 attach_deny_insecure_transport_policy  = false
  	 attach_deny_unencrypted_object_uploads  = false
  	 attach_elb_log_delivery_policy  = false
  	 attach_inventory_destination_policy  = false
  	 attach_lb_log_delivery_policy  = false
  	 attach_policy  = false
  	 attach_public_policy  = true
  	 attach_require_latest_tls_policy  = false
  	 block_public_acls  = true
  	 block_public_policy  = true
  	 bucket  = null
  	 bucket_prefix  = null
  	 control_object_ownership  = false
  	 cors_rule  = []
  	 create_bucket  = true
  	 expected_bucket_owner  = null
  	 force_destroy  = false
  	 grant  = []
  	 ignore_public_acls  = true
  	 intelligent_tiering  = {}
  	 inventory_configuration  = {}
  	 inventory_self_source_destination  = false
  	 inventory_source_account_id  = null
  	 inventory_source_bucket_arn  = null
  	 is_lambda_code_bucket  = false
  	 lifecycle_rule  = []
  	 logging  = {}
  	 metric_configuration  = []
  	 object_lock_configuration  = {}
  	 object_lock_enabled  = false
  	 object_ownership  = "BucketOwnerEnforced"
  	 owner  = {}
  	 policy  = null
  	 replication_configuration  = {}
  	 request_payer  = null
  	 restrict_public_buckets  = true
  	 server_side_encryption_configuration  = {}
  	 tags  = {}
  	 versioning  = {}
  	 website  = {}
}
```
## Resources

No resources.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acceleration_status"></a> [acceleration\_status](#input\_acceleration\_status) | (Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended. | `string` | `null` | no |
| <a name="input_access_log_delivery_policy_source_accounts"></a> [access\_log\_delivery\_policy\_source\_accounts](#input\_access\_log\_delivery\_policy\_source\_accounts) | (Optional) List of AWS Account IDs should be allowed to deliver access logs to this bucket. | `list(string)` | `[]` | no |
| <a name="input_access_log_delivery_policy_source_buckets"></a> [access\_log\_delivery\_policy\_source\_buckets](#input\_access\_log\_delivery\_policy\_source\_buckets) | (Optional) List of S3 bucket ARNs wich should be allowed to deliver access logs to this bucket. | `list(string)` | `[]` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional) The canned ACL to apply. Conflicts with `grant` | `string` | `null` | no |
| <a name="input_allowed_kms_key_arn"></a> [allowed\_kms\_key\_arn](#input\_allowed\_kms\_key\_arn) | The ARN of KMS key which should be allowed in PutObject | `string` | `null` | no |
| <a name="input_analytics_configuration"></a> [analytics\_configuration](#input\_analytics\_configuration) | Map containing bucket analytics configuration. | `any` | `{}` | no |
| <a name="input_analytics_self_source_destination"></a> [analytics\_self\_source\_destination](#input\_analytics\_self\_source\_destination) | Whether or not the analytics source bucket is also the destination bucket. | `bool` | `false` | no |
| <a name="input_analytics_source_account_id"></a> [analytics\_source\_account\_id](#input\_analytics\_source\_account\_id) | The analytics source account id. | `string` | `null` | no |
| <a name="input_analytics_source_bucket_arn"></a> [analytics\_source\_bucket\_arn](#input\_analytics\_source\_bucket\_arn) | The analytics source bucket ARN. | `string` | `null` | no |
| <a name="input_attach_access_log_delivery_policy"></a> [attach\_access\_log\_delivery\_policy](#input\_attach\_access\_log\_delivery\_policy) | Controls if S3 bucket should have S3 access log delivery policy attached | `bool` | `false` | no |
| <a name="input_attach_analytics_destination_policy"></a> [attach\_analytics\_destination\_policy](#input\_attach\_analytics\_destination\_policy) | Controls if S3 bucket should have bucket analytics destination policy attached. | `bool` | `false` | no |
| <a name="input_attach_deny_incorrect_encryption_headers"></a> [attach\_deny\_incorrect\_encryption\_headers](#input\_attach\_deny\_incorrect\_encryption\_headers) | Controls if S3 bucket should deny incorrect encryption headers policy attached. | `bool` | `false` | no |
| <a name="input_attach_deny_incorrect_kms_key_sse"></a> [attach\_deny\_incorrect\_kms\_key\_sse](#input\_attach\_deny\_incorrect\_kms\_key\_sse) | Controls if S3 bucket policy should deny usage of incorrect KMS key SSE. | `bool` | `false` | no |
| <a name="input_attach_deny_insecure_transport_policy"></a> [attach\_deny\_insecure\_transport\_policy](#input\_attach\_deny\_insecure\_transport\_policy) | Controls if S3 bucket should have deny non-SSL transport policy attached | `bool` | `false` | no |
| <a name="input_attach_deny_unencrypted_object_uploads"></a> [attach\_deny\_unencrypted\_object\_uploads](#input\_attach\_deny\_unencrypted\_object\_uploads) | Controls if S3 bucket should deny unencrypted object uploads policy attached. | `bool` | `false` | no |
| <a name="input_attach_elb_log_delivery_policy"></a> [attach\_elb\_log\_delivery\_policy](#input\_attach\_elb\_log\_delivery\_policy) | Controls if S3 bucket should have ELB log delivery policy attached | `bool` | `false` | no |
| <a name="input_attach_inventory_destination_policy"></a> [attach\_inventory\_destination\_policy](#input\_attach\_inventory\_destination\_policy) | Controls if S3 bucket should have bucket inventory destination policy attached. | `bool` | `false` | no |
| <a name="input_attach_lb_log_delivery_policy"></a> [attach\_lb\_log\_delivery\_policy](#input\_attach\_lb\_log\_delivery\_policy) | Controls if S3 bucket should have ALB/NLB log delivery policy attached | `bool` | `false` | no |
| <a name="input_attach_policy"></a> [attach\_policy](#input\_attach\_policy) | Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy) | `bool` | `false` | no |
| <a name="input_attach_public_policy"></a> [attach\_public\_policy](#input\_attach\_public\_policy) | Controls if a user defined public bucket policy will be attached (set to `false` to allow upstream to apply defaults to the bucket) | `bool` | `true` | no |
| <a name="input_attach_require_latest_tls_policy"></a> [attach\_require\_latest\_tls\_policy](#input\_attach\_require\_latest\_tls\_policy) | Controls if S3 bucket should require the latest version of TLS | `bool` | `false` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | (Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. | `string` | `null` | no |
| <a name="input_control_object_ownership"></a> [control\_object\_ownership](#input\_control\_object\_ownership) | Whether to manage S3 Bucket Ownership Controls on this bucket. | `bool` | `false` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | List of maps containing rules for Cross-Origin Resource Sharing. | `any` | `[]` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Controls if S3 bucket should be created | `bool` | `true` | no |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_grant"></a> [grant](#input\_grant) | An ACL policy grant. Conflicts with `acl` | `any` | `[]` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_intelligent_tiering"></a> [intelligent\_tiering](#input\_intelligent\_tiering) | Map containing intelligent tiering configuration. | `any` | `{}` | no |
| <a name="input_inventory_configuration"></a> [inventory\_configuration](#input\_inventory\_configuration) | Map containing S3 inventory configuration. | `any` | `{}` | no |
| <a name="input_inventory_self_source_destination"></a> [inventory\_self\_source\_destination](#input\_inventory\_self\_source\_destination) | Whether or not the inventory source bucket is also the destination bucket. | `bool` | `false` | no |
| <a name="input_inventory_source_account_id"></a> [inventory\_source\_account\_id](#input\_inventory\_source\_account\_id) | The inventory source account id. | `string` | `null` | no |
| <a name="input_inventory_source_bucket_arn"></a> [inventory\_source\_bucket\_arn](#input\_inventory\_source\_bucket\_arn) | The inventory source bucket ARN. | `string` | `null` | no |
| <a name="input_is_lambda_code_bucket"></a> [is\_lambda\_code\_bucket](#input\_is\_lambda\_code\_bucket) | Controls if S3 lambda sample zip object should be created | `bool` | `false` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Map containing access bucket logging configuration. | `any` | `{}` | no |
| <a name="input_metric_configuration"></a> [metric\_configuration](#input\_metric\_configuration) | Map containing bucket metric configuration. | `any` | `[]` | no |
| <a name="input_object_lock_configuration"></a> [object\_lock\_configuration](#input\_object\_lock\_configuration) | Map containing S3 object locking configuration. | `any` | `{}` | no |
| <a name="input_object_lock_enabled"></a> [object\_lock\_enabled](#input\_object\_lock\_enabled) | Whether S3 bucket should have an Object Lock configuration enabled. | `bool` | `false` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL. | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Bucket owner's display name and ID. Conflicts with `acl` | `map(string)` | `{}` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | (Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. | `string` | `null` | no |
| <a name="input_replication_configuration"></a> [replication\_configuration](#input\_replication\_configuration) | Map containing cross-region replication configuration. | `any` | `{}` | no |
| <a name="input_request_payer"></a> [request\_payer](#input\_request\_payer) | (Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information. | `string` | `null` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_server_side_encryption_configuration"></a> [server\_side\_encryption\_configuration](#input\_server\_side\_encryption\_configuration) | Map containing server-side encryption configuration. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the bucket. | `map(string)` | `{}` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Map containing versioning configuration. | `map(string)` | `{}` | no |
| <a name="input_website"></a> [website](#input\_website) | Map containing static web-site hosting or redirect configuration. | `any` | `{}` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->
