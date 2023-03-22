# S3 logging bucket

Example demonstrates creating an S3 bucket for logging S3 access to.

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

# Create logging bucket
module "example-logging-bucket" {
  source  = "so1omon563/s3/aws"
  version = "3.0.0" # Replace with appropriate version

  name = "example-logging-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
  canned_acl    = "log-delivery-write"
}
output "example-logging-bucket" { value = module.example-logging-bucket }

# Create bucket with logging enabled
module "example-bucket" {
  source  = "so1omon563/s3/aws"
  version = "3.0.0" # Replace with appropriate version

  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix     = "generic"
  s3_logging_bucket = module.example-logging-bucket.bucket.id
}
output "example-bucket" { value = module.example-bucket }
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-bucket"></a> [example-bucket](#module\_example-bucket) | so1omon563/s3/aws | 3.0.0 |
| <a name="module_example-logging-bucket"></a> [example-logging-bucket](#module\_example-logging-bucket) | so1omon563/s3/aws | 3.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example-bucket"></a> [example-bucket](#output\_example-bucket) | n/a |
| <a name="output_example-logging-bucket"></a> [example-logging-bucket](#output\_example-logging-bucket) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
