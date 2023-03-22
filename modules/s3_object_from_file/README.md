# S3 Object from File

Add a file as an object to an existing S3 bucket.

## Limitations

Can only be used to add files to an existing bucket. Cannot accept additional source types.
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
| [aws_s3_object.object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Name of the bucket to place the file in. Alternatively, an S3 access point ARN can be specified. | `string` | n/a | yes |
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | Whether or not to use [Amazon S3 Bucket Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html) for SSE-KMS. | `bool` | `false` | no |
| <a name="input_cache_control"></a> [cache\_control](#input\_cache\_control) | Specifies caching behavior along the request/reply chain Read [w3c cache\_control](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9) for further details. | `string` | `null` | no |
| <a name="input_canned_acl"></a> [canned\_acl](#input\_canned\_acl) | The canned ACL to use for the bucket. Note that the default is `private` by design. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options. | `string` | `"private"` | no |
| <a name="input_content_disposition"></a> [content\_disposition](#input\_content\_disposition) | Specifies presentational information for the object. Read [w3c content\_disposition](https://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1) for further information. | `string` | `null` | no |
| <a name="input_content_encoding"></a> [content\_encoding](#input\_content\_encoding) | Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field. Read [w3c content encoding](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11) for further information. | `string` | `null` | no |
| <a name="input_content_language"></a> [content\_language](#input\_content\_language) | The language the content is in e.g. en-US or en-GB, etc. | `string` | `null` | no |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input. | `string` | `null` | no |
| <a name="input_default_master_key"></a> [default\_master\_key](#input\_default\_master\_key) | Boolean to determine if the default master key is used. If false, and no kms\_arn is provided, AES256 will be used. | `bool` | `false` | no |
| <a name="input_file_source"></a> [file\_source](#input\_file\_source) | Path to the file to be uploaded | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Whether to allow the object to be deleted by removing any legal hold on any object version. Default is `false`. This value should be set to `true` only if the bucket has S3 object lock enabled. | `bool` | `false` | no |
| <a name="input_key"></a> [key](#input\_key) | The name of the object once it is in the bucket | `string` | n/a | yes |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | ARN of the KMS key to encrypt the object with. If not provided, the object will be encrypted with either the Default Master Key, or AES256 by default. | `string` | `null` | no |
| <a name="input_object_lock_legal_hold_status"></a> [object\_lock\_legal\_hold\_status](#input\_object\_lock\_legal\_hold\_status) | [Legal hold](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html#object-lock-legal-holds) status that you want to apply to the specified object. Valid values are `ON` and `OFF`. | `string` | `null` | no |
| <a name="input_object_lock_mode"></a> [object\_lock\_mode](#input\_object\_lock\_mode) | Object lock [retention mode](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html#object-lock-retention-modes) that you want to apply to the specified object. Valid values are `GOVERNANCE` and `COMPLIANCE`. | `string` | `null` | no |
| <a name="input_object_lock_retain_until_date"></a> [object\_lock\_retain\_until\_date](#input\_object\_lock\_retain\_until\_date) | Date and time, in [RFC3339 format](https://www.rfc-editor.org/rfc/rfc3339#section-5.8), when this object's object lock will [expire](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html#object-lock-retention-periods). | `string` | `null` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Specifies the desired Storage Class for the object. | `string` | `"STANDARD"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider. | `map(string)` | `{}` | no |
| <a name="input_website_redirect"></a> [website\_redirect](#input\_website\_redirect) | Specifies a target URL for [website redirect](https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-page-redirect.html). | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket-object"></a> [bucket-object](#output\_bucket-object) | A map of properties for the created object |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
