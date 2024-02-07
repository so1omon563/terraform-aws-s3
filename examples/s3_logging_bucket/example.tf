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
  version = "4.0.0" # Replace with appropriate version

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
  version = "4.0.0" # Replace with appropriate version

  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix     = "generic"
  s3_logging_bucket = module.example-logging-bucket.bucket.id
}
output "example-bucket" { value = module.example-bucket }
