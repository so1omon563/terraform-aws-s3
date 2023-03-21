# Basic usage

Basic usage example.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
data "aws_canonical_user_id" "current" {}
module "acl-s3" {
  source  = "so1omon563/s3/aws"
  version = "2.0.0" # Replace with appropriate version

  name          = "example-bucket"
  bucket_prefix = "acl-test"
  tags          = { example = "true" }
  canned_acl    = null
  access_control_policy = {
    grants = [{
      grant = {
        grantee = {
          email_address = null
          id            = data.aws_canonical_user_id.current.id
          type          = "CanonicalUser"
          uri           = null
        }
        permission = "READ"
      },

      grant = {
        grantee = {
          email_address = null
          id            = null
          type          = "Group"
          uri           = "http://acs.amazonaws.com/groups/s3/LogDelivery"

        }
        permission = "READ_ACP"
      }
    }]

    owner = {
      id           = data.aws_canonical_user_id.current.id
      display_name = null
    }

  }
  # object_ownership = null
}

output "acl-s3" { value = module.acl-s3 }
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acl-s3"></a> [acl-s3](#module\_acl-s3) | so1omon563/s3/aws | 2.0.0 |

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
