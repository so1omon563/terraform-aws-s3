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
  version = "4.0.0" # Replace with appropriate version

  name = "example-bucket-object"
  tags = {
    example = "true"
  }
  bucket_prefix = "generic"
}
output "example-generic-s3" { value = module.example-generic-s3 }

module "example-generic-object" {
  source  = "so1omon563/s3/aws//modules/s3_object_from_file"
  version = "3.0.0" # Replace with appropriate version

  tags = {
    example = "true"
  }
  bucket      = module.example-generic-s3.bucket.name
  file_source = "${path.module}/files/test_file.txt"
  key         = "test_file.txt"
}
output "example-generic-object" { value = module.example-generic-object }
