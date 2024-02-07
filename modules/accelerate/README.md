<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
## Examples

```hcl
# See examples under the top level examples directory for more information on how to use this module.
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_accelerate_configuration.accelerate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_accelerate_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | The name of the bucket. | `string` | n/a | yes |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_status"></a> [status](#input\_status) | Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accelerate"></a> [accelerate](#output\_accelerate) | A map of properties for the created accelerate configuration. |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
