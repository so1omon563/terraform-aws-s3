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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_grantee_email_address"></a> [grantee\_email\_address](#input\_grantee\_email\_address) | Email address of the grantee. See [Regions and Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) for supported AWS regions where this argument can be specified. | `string` | `null` | no |
| <a name="input_grantee_id"></a> [grantee\_id](#input\_grantee\_id) | The canonical user ID of the grantee. | `string` | `null` | no |
| <a name="input_grantee_type"></a> [grantee\_type](#input\_grantee\_type) | Type of grantee. Valid values: `CanonicalUser`, `AmazonCustomerByEmail`, `Group`. | `string` | `null` | no |
| <a name="input_grantee_uri"></a> [grantee\_uri](#input\_grantee\_uri) | URI of the grantee group. | `string` | `null` | no |
| <a name="input_target_bucket"></a> [target\_bucket](#input\_target\_bucket) | The name of the S3 bucket to log S3 access to. | `string` | n/a | yes |
| <a name="input_target_grant_permission"></a> [target\_grant\_permission](#input\_target\_grant\_permission) | Logging permissions assigned to the grantee for the bucket. Valid values: `FULL_CONTROL`, `READ`, `WRITE`. | `string` | `null` | no |
| <a name="input_target_prefix"></a> [target\_prefix](#input\_target\_prefix) | A prefix for all log object keys. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_logging"></a> [logging](#output\_logging) | A map of properties for the created logging configuration. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
