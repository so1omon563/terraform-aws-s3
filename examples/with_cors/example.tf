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
