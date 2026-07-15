# Buckets in multiple regions

Example of creating buckets in multiple regions.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

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
  source  = "so1omon563/s3/aws"
  version = "4.0.0" # Replace with appropriate version

  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
}
output "example-generic-s3-east" { value = module.example-generic-s3-east }

module "example-generic-s3-west" {
  source  = "so1omon563/s3/aws"
  version = "4.0.0" # Replace with appropriate version

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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0, < 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-generic-s3-east"></a> [example-generic-s3-east](#module\_example-generic-s3-east) | so1omon563/s3/aws | 4.0.0 |
| <a name="module_example-generic-s3-west"></a> [example-generic-s3-west](#module\_example-generic-s3-west) | so1omon563/s3/aws | 4.0.0 |

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
