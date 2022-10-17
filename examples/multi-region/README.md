# Buckets in multiple regions

Example of creating buckets in multiple regions.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
      region      = "us-east-1"
    }
  }
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
      region      = "us-west-2"
    }
  }
}

module "example-generic-s3-east" {
  source = "../../"

  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
}
output "example-generic-s3-east" { value = module.example-generic-s3-east }

module "example-generic-s3-west" {
  source = "../../"

  providers = {
    aws = aws.us-west-2
  }
  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
}
output "example-generic-s3-west" { value = module.example-generic-s3-west }
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-generic-s3-east"></a> [example-generic-s3-east](#module\_example-generic-s3-east) | ../../ | n/a |
| <a name="module_example-generic-s3-west"></a> [example-generic-s3-west](#module\_example-generic-s3-west) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example-generic-s3-east"></a> [example-generic-s3-east](#output\_example-generic-s3-east) | n/a |
| <a name="output_example-generic-s3-west"></a> [example-generic-s3-west](#output\_example-generic-s3-west) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
