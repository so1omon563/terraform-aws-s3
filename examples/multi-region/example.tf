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
