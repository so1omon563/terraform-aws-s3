# Generic S3 Bucket

Creates an S3 bucket using configuration resources introduced in provider version 4.0.

Can specify CORS and lifecycle policies as well as basic replication configuration, including creating an OAI for CloudFront.

This module enables encyption (either AES256 or KMS) and versioning by default.

All functionality outside of creating the bucket is handed off to submodules under the [modules](https://github.com/so1omon563/terraform-aws-s3/tree/main/modules) directory.
As a result, all of these submodules can also be used independently to handle configuration of existing buckets.

Additional features to come. See the [TODO](https://github.com/so1omon563/terraform-aws-s3/tree/main/TODO) for more information. Feature requests and additional contribution requests are welcome, per the [CONTRIBUTING](https://github.com/so1omon563/terraform-aws-s3/tree/main/CONTRIBUTING.md) guidelines.

Examples for use can be found under the [examples](https://github.com/so1omon563/terraform-aws-s3/tree/main/examples) directory.

## Limitations

- It is not possible to create an unencrypted S3 bucket with this module. This is by design.

- Only 1 lifecycle rule can be created in this module. If additional rules are needed, bypass the `lifecycle_*` variables and use the `lifecycle` module directly, which will allow you to leverage `for_each` at the module level to pass in multiple rules.

- It is only possible to use canned ACLs with this module at this time.

- Can only specify simple logging directly in this module. Additional grants etc. can be used by bypassing the `s3_logging_bucket` variable and using the `logging` submodule instead.

## Outputs problem

Since the AWS provider change to separate resources for S3 bucket configuration, note that the outputs of the S3 bucket itself may not reflect the configuration until the second time this module is run. This is because the S3 bucket resource is now created in a separate plan from the S3 bucket configuration. This is a known issue with Terraform and the AWS provider.

As a workaround, the submodules that are used to configure the S3 bucket each have their own outputs(`*_module` outputs). These outputs will reflect the configuration immediately. It is suggested that you use these outputs instead of the `s3_bucket` outputs.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.24.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_accelerate"></a> [accelerate](#module\_accelerate) | ./modules/accelerate | n/a |
| <a name="module_acl"></a> [acl](#module\_acl) | ./modules/acl | n/a |
| <a name="module_cors"></a> [cors](#module\_cors) | ./modules/cors | n/a |
| <a name="module_encryption"></a> [encryption](#module\_encryption) | ./modules/encryption | n/a |
| <a name="module_lifecycle"></a> [lifecycle](#module\_lifecycle) | ./modules/lifecycle | n/a |
| <a name="module_logging"></a> [logging](#module\_logging) | ./modules/logging | n/a |
| <a name="module_oai"></a> [oai](#module\_oai) | ./modules/oai | n/a |
| <a name="module_request_payer"></a> [request\_payer](#module\_request\_payer) | ./modules/request_payer | n/a |
| <a name="module_versioning"></a> [versioning](#module\_versioning) | ./modules/versioning | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.generic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerate_status"></a> [accelerate\_status](#input\_accelerate\_status) | Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`. | `string` | `null` | no |
| <a name="input_bucket_name_override"></a> [bucket\_name\_override](#input\_bucket\_name\_override) | Used if there is a need to specify a bucket name outside of the standardized nomenclature. For example, if importing a bucket that doesn't follow the standard naming formats. | `string` | `null` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | Bucket name prefix, will be pre-pended to AWS account ID and region to make bucket unique | `string` | `null` | no |
| <a name="input_canned_acl"></a> [canned\_acl](#input\_canned\_acl) | The canned ACL to use for the bucket. Note that the default is `private`, which will also add a (public access block)[https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block] to the bucket. | `string` | `"private"` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | Map of properties for optional CORS rules. See [aws\_s3\_bucket\_cors\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) for more info. Note that values are required for all objects, even if the value is `null`. | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    id              = string<br>    max_age_seconds = number<br>  }))</pre> | `null` | no |
| <a name="input_enable_oai"></a> [enable\_oai](#input\_enable\_oai) | If this is set to `true`, an [Origin Access Identity](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) for use with CloudFront. | `bool` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Can be used to override the values in `local.encryption_defaults`.<br><br>  If `use_kms` is set to false, the bucket will be encrypted using the default `AES256` algorithm.<br><br>  If `use_bucket_keys` is set to `true`, a dedicated bucket key will be enabled, as outlined [here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html).<br><br>  Default local values are:<pre>encryption_defaults = {<br>    use_kms         = true<br>    use_bucket_keys = false<br>  }</pre> | `map(string)` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of the KMS key to encrypt the bucket with. If no value is provided, and the `encryption.use_kms` variable is set to `true`, the bucket will be encrypted using the default `aws/s3` AWS KMS master key. | `string` | `null` | no |
| <a name="input_lifecycle_abort_incomplete_multipart_upload"></a> [lifecycle\_abort\_incomplete\_multipart\_upload](#input\_lifecycle\_abort\_incomplete\_multipart\_upload) | Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see [Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the Amazon Simple Storage Service Developer Guide. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    days_after_initiation = number<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_expiration"></a> [lifecycle\_expiration](#input\_lifecycle\_expiration) | Specifies when an object transitions to a specified storage class. See [Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    date                         = string<br>    days                         = number<br>    expired_object_delete_marker = bool<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_filter"></a> [lifecycle\_filter](#input\_lifecycle\_filter) | Specifies a filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. | `map(string)` | `null` | no |
| <a name="input_lifecycle_filter_and"></a> [lifecycle\_filter\_and](#input\_lifecycle\_filter\_and) | Specifies a logical AND to two or more predicates for the filter. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. | `map(string)` | `null` | no |
| <a name="input_lifecycle_filter_tag"></a> [lifecycle\_filter\_tag](#input\_lifecycle\_filter\_tag) | Specifies a tag in the filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. | `map(string)` | `null` | no |
| <a name="input_lifecycle_noncurrent_version_expiration"></a> [lifecycle\_noncurrent\_version\_expiration](#input\_lifecycle\_noncurrent\_version\_expiration) | Specifies when noncurrent objects expires. See [Noncurrent Version Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    newer_noncurrent_versions = number<br>    noncurrent_days           = number<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_noncurrent_version_transition"></a> [lifecycle\_noncurrent\_version\_transition](#input\_lifecycle\_noncurrent\_version\_transition) | Specifies when noncurrent object versions transition to a specified storage class. See [Noncurrent Version Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_transition) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    newer_noncurrent_versions = number<br>    noncurrent_days           = number<br>    storage_class             = string<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | Properties for an optional lifecycle rule. See [aws\_s3\_bucket\_lifecycle\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    id      = string<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_lifecycle_transition"></a> [lifecycle\_transition](#input\_lifecycle\_transition) | Specifies when an object transitions to a specified storage class. See [Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#transition) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    date          = string<br>    days          = number<br>    storage_class = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Short, descriptive name of the environment. All resources will be named using this value as a prefix. | `string` | n/a | yes |
| <a name="input_replication_configuration"></a> [replication\_configuration](#input\_replication\_configuration) | Map of properties for an optional set of replication rules. See [aws\_s3\_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) for more info. Note that values are required for all objects, even if the value is `null`. | <pre>list(object({<br>    role = string<br>    rules = list(object({<br>      id     = string<br>      prefix = string<br>      status = string<br>      destination = list(object({<br>        bucket             = string<br>        storage_class      = string<br>        replica_kms_key_id = string<br>        account_id         = string<br>        access_control_translation = list(object({<br>          owner = string<br>        }))<br>      }))<br>      source_selection_criteria = list(object({<br>        enabled = string<br>      }))<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_request_payer"></a> [request\_payer](#input\_request\_payer) | Specifies who should bear the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer. See [Requester Pays Buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html) developer guide for more information. | `map(string)` | <pre>{<br>  "expected_bucket_owner": null,<br>  "request_payer": "BucketOwner"<br>}</pre> | no |
| <a name="input_s3_logging_bucket"></a> [s3\_logging\_bucket](#input\_s3\_logging\_bucket) | The name of the S3 bucket to log S3 access to. Will be passed to the `logging` submodule. If not provided, logging will be disabled. For additional logging options, bypass this variable, and call the submodule directly. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_versioning_configuration"></a> [versioning\_configuration](#input\_versioning\_configuration) | A map of versioning configuration for the bucket. Will be passed to the `versioning` submodule. Please see documentation for that submodule for more information on valid entries. | `map(string)` | <pre>{<br>  "expected_bucket_owner": null,<br>  "mfa_delete": "Disabled",<br>  "mfa_device": null,<br>  "status": "Enabled"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accelerate_module"></a> [accelerate\_module](#output\_accelerate\_module) | A map of properties for the created accelerate configuration. |
| <a name="output_acl_module"></a> [acl\_module](#output\_acl\_module) | A map of properties for the bucket's canned ACL configuration. |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | A map of properties for the created bucket. |
| <a name="output_cors_module"></a> [cors\_module](#output\_cors\_module) | A map of properties for the bucket's CORS configuration. |
| <a name="output_encryption_module"></a> [encryption\_module](#output\_encryption\_module) | A map of properties for the bucket's encryption configuration. |
| <a name="output_lifecycle_module"></a> [lifecycle\_module](#output\_lifecycle\_module) | A map of properties for the created lifecycle configuration. |
| <a name="output_logging_module"></a> [logging\_module](#output\_logging\_module) | A map of properties for the created logging configuration. |
| <a name="output_oai_module"></a> [oai\_module](#output\_oai\_module) | A map of properties for the created origin access identity. |
| <a name="output_request_payer_module"></a> [request\_payer\_module](#output\_request\_payer\_module) | A map of properties for the request payer configuration. |
| <a name="output_versioning_module"></a> [versioning\_module](#output\_versioning\_module) | A map of properties for the created versioning configuration. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
