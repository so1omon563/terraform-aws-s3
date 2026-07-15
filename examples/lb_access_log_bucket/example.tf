terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

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
  version = "4.0.0" # Replace with appropriate version

  name = "example-lb-logging-bucket"
  tags = {
    example = "true"
  }
  bucket_prefix  = "generic"
  lb_access_logs = true
}
output "example-lb-logging-bucket" { value = module.example-lb-logging-bucket }
