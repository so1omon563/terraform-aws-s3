# Basic usage

Basic usage example.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
data "aws_canonical_user_id" "current" {}

module "acl-s3" {
  source  = "so1omon563/s3/aws"
  version = "4.0.0" # Replace with appropriate version

  name          = "example-bucket"
  bucket_prefix = "acl-test"
  tags          = { example = "true" }

  object_ownership = "ObjectWriter"

  access_control_policy_grants = [
    {
      type       = "CanonicalUser"
      permission = "FULL_CONTROL"
      id         = data.aws_canonical_user_id.current.id
    },
    {
      type       = "Group"
      permission = "READ_ACP"
      uri        = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    }
  ]
  access_control_policy_owner = {
    id = data.aws_canonical_user_id.current.id
  }
}

output "acl-s3" { value = module.acl-s3 }
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acl-s3"></a> [acl-s3](#module\_acl-s3) | so1omon563/s3/aws | 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_canonical_user_id.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl-s3"></a> [acl-s3](#output\_acl-s3) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
