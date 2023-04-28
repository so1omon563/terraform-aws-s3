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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.65.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_acl.acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_canonical_user_id.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_control_policy_grants"></a> [access\_control\_policy\_grants](#input\_access\_control\_policy\_grants) | Map of values for the grant block of the [access\_control\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. See `with_acl_grants` example for usage examples. | `any` | `[]` | no |
| <a name="input_access_control_policy_owner"></a> [access\_control\_policy\_owner](#input\_access\_control\_policy\_owner) | Map of values for the owner block of the [access\_control\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. See `with_acl_grants` example for usage examples. | `map(string)` | `null` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_canned_acl"></a> [canned\_acl](#input\_canned\_acl) | The canned ACL to use for the bucket. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options. If you wish to use an `access_control_policy`, this must be set to `null`. | `string` | `null` | no |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl"></a> [acl](#output\_acl) | A map of properties for the bucket's ACL configuration. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
