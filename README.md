# Generic S3 Bucket

Creates an S3 bucket using configuration resources introduced in provider version 4.0.

Can specify CORS and lifecycle policies, including creating an OAI for CloudFront.

This module enables encyption (either AES256 or KMS) and versioning by default.

All functionality outside of creating the bucket is handed off to submodules under the `modules` directory.
As a result, all of these submodules can also be used independently to handle configuration of existing buckets. Please review them to ensure you understand what is needed for your use case.

Additional features to come. See the [TODO](TODO) for more information. Feature requests and additional contribution requests are welcome, per the [CONTRIBUTING](CONTRIBUTING.md) guidelines.

**Note that versions prior to 3.3.0 had significant bugs in the ACL configuration. Please upgrade to 3.3.0 or later if you are using ACLs.**

## Limitations

- It is not possible to create an unencrypted S3 bucket with this module. This is by design.

- This module implements the new default standards for Object Ownership and Public Access Blocking that AWS is introducing in April 2023. See [Controlling ownership of objects and disabling ACLs for your bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) for more information.

- This module does not support website configurations. For website option, look into using the [aws_s3_bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) resource directly.

- This module does not currently support replication configuration. For replication options, look into using the [aws_s3_bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication) resource directly.

- Only 1 lifecycle rule can be created by this main module. If additional rules are needed, bypass the `lifecycle_*` variables and use the `lifecycle` submodule directly, which will allow you to leverage `for_each` at the module level to pass in multiple rules.

- Can only specify simple logging directly in this module. Additional grants etc. can be used by bypassing the `s3_logging_bucket` variable and using the `logging` submodule instead.

- Can not add object locking to existing buckets. This is largely a limitation of AWS, since it requires a token from AWS support. See [aws_s3_bucket_object_lock_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) for more information.

## Outputs problem

Since the AWS provider change to separate resources for S3 bucket configuration, the outputs of the S3 bucket itself may not fully reflect the configuration until the second time this module is run. This is because the S3 bucket resource is now created in a separate plan from the S3 bucket configuration. This is a known issue with Terraform and the AWS provider.

As a workaround, the submodules that are used to configure the S3 bucket each have their own outputs(`*_module` outputs). These outputs will reflect the configuration immediately. It is suggested that you use these outputs instead of the `s3_bucket` outputs. On newer provider versions, this issue has largely been solved. The additional outputs remain here to allow for compatibilty with those original providers (4.0, etc).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.48.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_accelerate"></a> [accelerate](#module\_accelerate) | ./modules/accelerate | n/a |
| <a name="module_access_control_policy"></a> [access\_control\_policy](#module\_access\_control\_policy) | ./modules/acl | n/a |
| <a name="module_canned_acl"></a> [canned\_acl](#module\_canned\_acl) | ./modules/acl | n/a |
| <a name="module_cors"></a> [cors](#module\_cors) | ./modules/cors | n/a |
| <a name="module_encryption"></a> [encryption](#module\_encryption) | ./modules/encryption | n/a |
| <a name="module_lb_access_logs"></a> [lb\_access\_logs](#module\_lb\_access\_logs) | ./modules/policy | n/a |
| <a name="module_lifecycle"></a> [lifecycle](#module\_lifecycle) | ./modules/lifecycle | n/a |
| <a name="module_logging"></a> [logging](#module\_logging) | ./modules/logging | n/a |
| <a name="module_oai"></a> [oai](#module\_oai) | ./modules/oai | n/a |
| <a name="module_object_locking"></a> [object\_locking](#module\_object\_locking) | ./modules/object_locking | n/a |
| <a name="module_object_ownership"></a> [object\_ownership](#module\_object\_ownership) | ./modules/object_ownership | n/a |
| <a name="module_policy"></a> [policy](#module\_policy) | ./modules/policy | n/a |
| <a name="module_public_access_block"></a> [public\_access\_block](#module\_public\_access\_block) | ./modules/public_access_block | n/a |
| <a name="module_request_payer"></a> [request\_payer](#module\_request\_payer) | ./modules/request_payer | n/a |
| <a name="module_versioning"></a> [versioning](#module\_versioning) | ./modules/versioning | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.generic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_elb_service_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb_service_account) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerate_status"></a> [accelerate\_status](#input\_accelerate\_status) | Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`. | `string` | `null` | no |
| <a name="input_access_control_policy_grants"></a> [access\_control\_policy\_grants](#input\_access\_control\_policy\_grants) | Map of values for the grant block of the [access\_control\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. May also conflict with `object_ownership`. See that variable for more information. See `with_acl_grants` example for usage examples. | `any` | `[]` | no |
| <a name="input_access_control_policy_owner"></a> [access\_control\_policy\_owner](#input\_access\_control\_policy\_owner) | Map of values for the owner block of the [access\_control\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. May also conflict with `object_ownership`. See that variable for more information. See `with_acl_grants` example for usage examples. | `map(string)` | `null` | no |
| <a name="input_bucket_name_override"></a> [bucket\_name\_override](#input\_bucket\_name\_override) | Used if there is a need to specify a bucket name outside of the standardized nomenclature. For example, if importing a bucket that doesn't follow the standard naming formats. | `string` | `null` | no |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | Optional bucket policy in JSON format. Although this is a bucket policy rather than an IAM policy, the [aws\_iam\_policy\_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/tutorials/terraform/aws-iam-policy?_ga=2.150865718.1068941414.1658759740-2145690310.1655932481). Note: Bucket policies are limited to 20 KB in size. | `string` | `null` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | Bucket name prefix, will be pre-pended to AWS account ID and region to make bucket unique | `string` | `null` | no |
| <a name="input_canned_acl"></a> [canned\_acl](#input\_canned\_acl) | The canned ACL to use for the bucket. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options. If you wish to use an `access_control_policy`, this must be set to `null`. | `string` | `null` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | Map of properties for optional CORS rules. See [aws\_s3\_bucket\_cors\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) for more info. Note that values are required for all objects, even if the value is `null`. | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    id              = string<br>    max_age_seconds = number<br>  }))</pre> | `null` | no |
| <a name="input_enable_oai"></a> [enable\_oai](#input\_enable\_oai) | If this is set to `true`, an [Origin Access Identity](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) for use with CloudFront. | `bool` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Can be used to override the values in `local.encryption_defaults`.<br><br>  If `use_kms` is set to false, the bucket will be encrypted using the default `AES256` algorithm.<br><br>  If `use_bucket_keys` is set to `true`, a dedicated bucket key will be enabled, as outlined [here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html).<br><br>  Default local values are:<pre>encryption_defaults = {<br>    use_kms         = true<br>    use_bucket_keys = false<br>  }</pre> | `map(string)` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of the KMS key to encrypt the bucket with. If no value is provided, and the `encryption.use_kms` variable is set to `true`, the bucket will be encrypted using the default `aws/s3` AWS KMS master key. | `string` | `null` | no |
| <a name="input_lb_access_logs"></a> [lb\_access\_logs](#input\_lb\_access\_logs) | Should the bucket be able to be used as an access log bucket for an ELB? If set to `true`, the bucket will be configured to allow access from the ELB service principal. | `bool` | `false` | no |
| <a name="input_lifecycle_abort_incomplete_multipart_upload"></a> [lifecycle\_abort\_incomplete\_multipart\_upload](#input\_lifecycle\_abort\_incomplete\_multipart\_upload) | Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see [Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the Amazon Simple Storage Service Developer Guide. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    days_after_initiation = number<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_expiration"></a> [lifecycle\_expiration](#input\_lifecycle\_expiration) | Specifies when an object transitions to a specified storage class. See [Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    date                         = string<br>    days                         = number<br>    expired_object_delete_marker = bool<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_filter"></a> [lifecycle\_filter](#input\_lifecycle\_filter) | Specifies a filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. | `map(string)` | `null` | no |
| <a name="input_lifecycle_filter_and"></a> [lifecycle\_filter\_and](#input\_lifecycle\_filter\_and) | Specifies a logical AND to two or more predicates for the filter. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. | `map(string)` | `null` | no |
| <a name="input_lifecycle_filter_tag"></a> [lifecycle\_filter\_tag](#input\_lifecycle\_filter\_tag) | Specifies a tag in the filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. | `map(string)` | `null` | no |
| <a name="input_lifecycle_noncurrent_version_expiration"></a> [lifecycle\_noncurrent\_version\_expiration](#input\_lifecycle\_noncurrent\_version\_expiration) | Specifies when noncurrent objects expires. See [Noncurrent Version Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    newer_noncurrent_versions = number<br>    noncurrent_days           = number<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_noncurrent_version_transition"></a> [lifecycle\_noncurrent\_version\_transition](#input\_lifecycle\_noncurrent\_version\_transition) | Specifies when noncurrent object versions transition to a specified storage class. See [Noncurrent Version Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_transition) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    newer_noncurrent_versions = number<br>    noncurrent_days           = number<br>    storage_class             = string<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | Properties for an optional lifecycle rule. See [aws\_s3\_bucket\_lifecycle\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    id      = string<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_transition"></a> [lifecycle\_transition](#input\_lifecycle\_transition) | Specifies when an object transitions to a specified storage class. See [Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#transition) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    date          = string<br>    days          = number<br>    storage_class = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. Either this variable, or `bucket_name_override` must be set. | `string` | `null` | no |
| <a name="input_object_lock_configuration"></a> [object\_lock\_configuration](#input\_object\_lock\_configuration) | Map of properties for an optional object lock configuration. See [Object Lock Configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    days  = number<br>    mode  = string<br>    years = number<br>  })</pre> | `null` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Object ownership. Valid values: `BucketOwnerPreferred`, `ObjectWriter` or `BucketOwnerEnforced`. If ACLs (canned or otherwise) are required, then `BucketOwnerPreferred`, or `ObjectWriter` must be used. See [s3\_bucket\_ownership\_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) for more information on the options. | `string` | `"BucketOwnerEnforced"` | no |
| <a name="input_public_access_block"></a> [public\_access\_block](#input\_public\_access\_block) | Public Access Block configuration. See [s3\_bucket\_public\_access\_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) for more information on the options. | <pre>object({<br>    block_public_acls       = bool<br>    block_public_policy     = bool<br>    ignore_public_acls      = bool<br>    restrict_public_buckets = bool<br>  })</pre> | <pre>{<br>  "block_public_acls": true,<br>  "block_public_policy": true,<br>  "ignore_public_acls": true,<br>  "restrict_public_buckets": true<br>}</pre> | no |
| <a name="input_request_payer"></a> [request\_payer](#input\_request\_payer) | Specifies who should bear the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer. See [Requester Pays Buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html) developer guide for more information. | `map(string)` | <pre>{<br>  "expected_bucket_owner": null,<br>  "request_payer": "BucketOwner"<br>}</pre> | no |
| <a name="input_s3_logging_bucket"></a> [s3\_logging\_bucket](#input\_s3\_logging\_bucket) | The name of the S3 bucket to log S3 access to. Will be passed to the `logging` submodule. If not provided, logging will be disabled. For additional logging options, bypass this variable, and call the submodule directly. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_versioning_configuration"></a> [versioning\_configuration](#input\_versioning\_configuration) | A map of versioning configuration for the bucket. Will be passed to the `versioning` submodule. Please see documentation for that submodule for more information on valid entries. | `map(string)` | <pre>{<br>  "expected_bucket_owner": null,<br>  "mfa_delete": "Disabled",<br>  "mfa_device": null,<br>  "status": "Enabled"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accelerate_module"></a> [accelerate\_module](#output\_accelerate\_module) | A map of properties for the created accelerate configuration. |
| <a name="output_access_control_policy_module"></a> [access\_control\_policy\_module](#output\_access\_control\_policy\_module) | A map of properties for the bucket's specific (not canned) ACL configuration. |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | A map of properties for the created bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the created bucket. |
| <a name="output_canned_acl_module"></a> [canned\_acl\_module](#output\_canned\_acl\_module) | A map of properties for the bucket's canned ACL configuration. |
| <a name="output_cors_module"></a> [cors\_module](#output\_cors\_module) | A map of properties for the bucket's CORS configuration. |
| <a name="output_encryption_module"></a> [encryption\_module](#output\_encryption\_module) | A map of properties for the bucket's encryption configuration. |
| <a name="output_lb_access_logs_module"></a> [lb\_access\_logs\_module](#output\_lb\_access\_logs\_module) | A map of properties for the created bucket policy to allow LB access logging. |
| <a name="output_lifecycle_module"></a> [lifecycle\_module](#output\_lifecycle\_module) | A map of properties for the created lifecycle configuration. |
| <a name="output_logging_module"></a> [logging\_module](#output\_logging\_module) | A map of properties for the created logging configuration. |
| <a name="output_oai_module"></a> [oai\_module](#output\_oai\_module) | A map of properties for the created origin access identity. |
| <a name="output_object_locking_module"></a> [object\_locking\_module](#output\_object\_locking\_module) | A map of properties for the object locking configuration. |
| <a name="output_object_ownership_module"></a> [object\_ownership\_module](#output\_object\_ownership\_module) | A map of properties for the bucket's object ownership configuration. |
| <a name="output_policy_module"></a> [policy\_module](#output\_policy\_module) | A map of properties for the created bucket policy. |
| <a name="output_public_access_block_module"></a> [public\_access\_block\_module](#output\_public\_access\_block\_module) | A map of properties for the bucket's Public Access Block configuration. |
| <a name="output_request_payer_module"></a> [request\_payer\_module](#output\_request\_payer\_module) | A map of properties for the request payer configuration. |
| <a name="output_versioning_module"></a> [versioning\_module](#output\_versioning\_module) | A map of properties for the created versioning configuration. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
