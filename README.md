# Generic S3 Bucket

Creates an S3 bucket. Can specify CORS and lifecycle policies as well as basic replication configuration. Can also be configured to create an OAI for CloudFront.

This module enables encyption (either AES256 or KMS) and versioning by default. By design, it is not possible to create an unencrypted S3 bucket with this module.

It is only possible to use canned ACLs with this module.

Can only specify simple logging directly in this module. Additional grants etc. can be used by bypassing the `s3_logging_bucket` variable and using the `logging` submodule instead.

Additional features to come. See the [TODO](https://github.com/so1omon563/terraform-aws-s3/tree/main/TODO) for more information. Feature requests and additional contribution requests are welcome, per the [CONTRIBUTING](https://github.com/so1omon563/terraform-aws-s3/tree/main/CONTRIBUTING.md) guidelines.

These submodules can be found under the [modules](https://github.com/so1omon563/terraform-aws-s3/tree/main/modules) directory.

Examples for use can be found under the [examples](https://github.com/so1omon563/terraform-aws-s3/tree/main/examples) directory.

## Outputs problem

Since the AWS provider change to separate resources for S3 bucket configuration, note that the outputs of the S3 bucket itself may not reflect the configuration until the second time this module is run. This is because the S3 bucket resource is now created in a separate plan from the S3 bucket configuration. This is a known issue with Terraform and the AWS provider.

As a workaround, the submodules that are used to configure the S3 bucket each have their own outputs. These outputs will reflect the configuration immediately.

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
| <a name="module_encryption"></a> [encryption](#module\_encryption) | ./modules/encryption | n/a |
| <a name="module_logging"></a> [logging](#module\_logging) | ./modules/logging | n/a |
| <a name="module_oai"></a> [oai](#module\_oai) | ./modules/oai | n/a |
| <a name="module_request_payer"></a> [request\_payer](#module\_request\_payer) | ./modules/request_payer | n/a |
| <a name="module_versioning"></a> [versioning](#module\_versioning) | ./modules/versioning | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.generic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.canned_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.generic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerate_status"></a> [accelerate\_status](#input\_accelerate\_status) | Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`. | `string` | `null` | no |
| <a name="input_bucket_name_override"></a> [bucket\_name\_override](#input\_bucket\_name\_override) | Used if there is a need to specify a bucket name outside of the standardized nomenclature. For example, if importing a bucket that doesn't follow the standard naming formats. | `string` | `null` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | Bucket name prefix, will be pre-pended to AWS account ID and region to make bucket unique | `string` | `null` | no |
| <a name="input_canned_acl"></a> [canned\_acl](#input\_canned\_acl) | The canned ACL to use for the bucket. Note that the default is `private`, which will also add a public access block to the bucket. | `string` | `"private"` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | Map of properties for an optional CORS rule. See [aws\_s3\_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) for more info. Note that values are required for all objects, even if the value is `null`. | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `null` | no |
| <a name="input_enable_oai"></a> [enable\_oai](#input\_enable\_oai) | If this is set to `true`, an [Origin Access Identity](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) for use with CloudFront. | `bool` | `false` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Can be used to override the values in `local.encryption_defaults`.<br><br>  If `use_kms` is set to false, the bucket will be encrypted using the default `AES256` algorithm.<br><br>  If `use_bucket_keys` is set to `true`, a dedicated bucket key will be enabled, as outlined [here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html).<br><br>  Default local values are:<pre>encryption_defaults = {<br>    use_kms         = true<br>    use_bucket_keys = false<br>  }</pre> | `map(string)` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of the KMS key to encrypt the bucket with. If no value is provided, and the `encryption.use_kms` variable is set to `true`, the bucket will be encrypted using the default `aws/s3` AWS KMS master key. | `string` | `null` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | Map of properties for an optional lifecycle rule. See [aws\_s3\_bucket\_lifecycle\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. Note that values are required for all objects, even if the value is `null`. | <pre>list(object({<br>    id                                     = string<br>    enabled                                = bool<br>    abort_incomplete_multipart_upload_days = string<br>    filter = object({<br>      prefix = string<br>    })<br>    expiration = list(object({<br>      date                         = string<br>      days                         = number<br>      expired_object_delete_marker = string<br>    }))<br>    transition = list(object({<br>      date          = string<br>      days          = number<br>      storage_class = string<br>    }))<br>    noncurrent_version_transition = list(object({<br>      days          = number<br>      storage_class = string<br>    }))<br>    noncurrent_version_expiration = list(object({<br>      days = number<br>    }))<br>  }))</pre> | `null` | no |
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
| <a name="output_bucket"></a> [bucket](#output\_bucket) | A map of properties for the created bucket. |
| <a name="output_encryption_module"></a> [encryption\_module](#output\_encryption\_module) | A map of properties for the bucket's encryption configuration. |
| <a name="output_logging_module"></a> [logging\_module](#output\_logging\_module) | A map of properties for the created logging configuration. |
| <a name="output_oai_module"></a> [oai\_module](#output\_oai\_module) | A map of properties for the created origin access identity. |
| <a name="output_versioning_module"></a> [versioning\_module](#output\_versioning\_module) | A map of properties for the created versioning configuration. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
