# LB access logging bucket

Example of creating a Load Balancer access logging bucket.

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

# Create LB access logging bucket
module "example-lb-logging-bucket" {
  source  = "so1omon563/s3/aws"
  version = "2.0.0" # Replace with appropriate version

  name = "example-lb-logging-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix  = "generic"
  lb_access_logs = true
}
output "example-lb-logging-bucket" { value = module.example-lb-logging-bucket }
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example-lb-logging-bucket"></a> [example-lb-logging-bucket](#module\_example-lb-logging-bucket) | so1omon563/s3/aws | 2.0.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_example-lb-logging-bucket"></a> [example-lb-logging-bucket](#output\_example-lb-logging-bucket) | n/a |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
