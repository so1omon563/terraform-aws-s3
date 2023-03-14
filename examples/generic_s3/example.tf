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
  version = "1.3.0" # Replace with appropriate version

  name = "example-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
}
output "example-generic-s3" { value = module.example-generic-s3 }
