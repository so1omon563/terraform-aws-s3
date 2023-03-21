<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_lifecycle_configuration.lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_abort_incomplete_multipart_upload"></a> [abort\_incomplete\_multipart\_upload](#input\_abort\_incomplete\_multipart\_upload) | Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see [Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the Amazon Simple Storage Service Developer Guide. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    days_after_initiation = number<br>  })</pre> | `null` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_expiration"></a> [expiration](#input\_expiration) | Specifies when an object transitions to a specified storage class. See [Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    date                         = string<br>    days                         = number<br>    expired_object_delete_marker = bool<br>  })</pre> | `null` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | Specifies a filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. If using this variable, all values must be populated, even if that value is `null`. | `map(string)` | `null` | no |
| <a name="input_filter_and"></a> [filter\_and](#input\_filter\_and) | Specifies a logical AND to two or more predicates for the filter. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. If using this variable, all values must be populated, even if that value is `null`. | `map(string)` | `null` | no |
| <a name="input_filter_tag"></a> [filter\_tag](#input\_filter\_tag) | Specifies a tag in the filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. If using this variable, all values must be populated, even if that value is `null`. | `map(string)` | `null` | no |
| <a name="input_noncurrent_version_expiration"></a> [noncurrent\_version\_expiration](#input\_noncurrent\_version\_expiration) | Specifies when noncurrent objects expires. See [Noncurrent Version Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    newer_noncurrent_versions = number<br>    noncurrent_days           = number<br>  })</pre> | `null` | no |
| <a name="input_noncurrent_version_transition"></a> [noncurrent\_version\_transition](#input\_noncurrent\_version\_transition) | Specifies when noncurrent object versions transition to a specified storage class. See [Noncurrent Version Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_transition) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    newer_noncurrent_versions = number<br>    noncurrent_days           = number<br>    storage_class             = string<br>  })</pre> | `null` | no |
| <a name="input_rule"></a> [rule](#input\_rule) | Properties for an optional lifecycle rule. See [aws\_s3\_bucket\_lifecycle\_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    id      = string<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_transition"></a> [transition](#input\_transition) | Specifies when an object transitions to a specified storage class. See [Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#transition) for more info. If using this variable, all values must be populated, even if that value is `null`. | <pre>object({<br>    date          = string<br>    days          = number<br>    storage_class = string<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lifecycle"></a> [lifecycle](#output\_lifecycle) | A map of properties for the bucket's lifecycle configuration. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
