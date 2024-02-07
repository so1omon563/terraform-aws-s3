# Bucket with CORS

Example of creating a bucket with CORS configuration.

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

module "example-with-cors" {
  source  = "so1omon563/s3/aws"
  version = "4.0.0" # Replace with appropriate version

  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix = "with-cors"
  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET"]
      allowed_origins = ["https://google.com"]
      expose_headers  = ["ETag"]
      id              = null
      max_age_seconds = 3000
    }
  ]
}
output "example-with-cors" { value = module.example-with-cors }
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-with-cors"></a> [example-with-cors](#module\_example-with-cors) | so1omon563/s3/aws | 4.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example-with-cors"></a> [example-with-cors](#output\_example-with-cors) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
