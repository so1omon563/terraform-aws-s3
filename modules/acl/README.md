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
| [aws_s3_bucket_acl.acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.generic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_control_policy"></a> [access\_control\_policy](#input\_access\_control\_policy) | Map of values for the [access\_control\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. If this is set, `canned_acl` must be set to `null`. Note that values are required for all objects, even if the value is `null`. | <pre>object({<br>    grants = list(object({<br>      grant = object({<br>        grantee = object({<br>          email_address = string<br>          id            = string<br>          type          = string<br>          uri           = string<br>        })<br>        permission = string<br>      })<br>    }))<br>    owner = object({<br>      id           = string<br>      display_name = string<br>    })<br>  })</pre> | `null` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_canned_acl"></a> [canned\_acl](#input\_canned\_acl) | The canned ACL to use for the bucket. Note that the default is `private`, which will also add a (public access block)[https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block] to the bucket. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options. If you wish to use an `access_control_policy`, this must be set to `null`. | `string` | `"private"` | no |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl"></a> [acl](#output\_acl) | A map of properties for the bucket's ACL configuration. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
