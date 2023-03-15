# Basic usage

Basic usage example.

Example shows using Default Tags in the provider as well as passing additional tags into the resource.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Examples

```hcl
provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

module "example-generic-s3" {
  source  = "so1omon563/s3/aws"
  version = "1.4.0" # Replace with appropriate version

  name = "example-bucket-object"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
}
output "example-generic-s3" { value = module.example-generic-s3 }

module "example-generic-object" {
  source  = "so1omon563/s3/aws//modules/s3_object_from_file"
  version = "1.4.0" # Replace with appropriate version

  tags = {
    example = "true"
  }
  bucket      = module.example-generic-s3.bucket.name
  file_source = "${path.module}/files/test_file.txt"
  key         = "test_file.txt"
}
output "example-generic-object" { value = module.example-generic-object }
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-generic-object"></a> [example-generic-object](#module\_example-generic-object) | so1omon563/s3/aws//modules/s3_object_from_file | 1.4.0 |
| <a name="module_example-generic-s3"></a> [example-generic-s3](#module\_example-generic-s3) | so1omon563/s3/aws | 1.4.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example-generic-object"></a> [example-generic-object](#output\_example-generic-object) | n/a |
| <a name="output_example-generic-s3"></a> [example-generic-s3](#output\_example-generic-s3) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
