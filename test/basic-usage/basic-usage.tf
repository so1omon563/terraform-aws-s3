variable "name" {
  default = "default-s3"
}

variable "tags" {
  default = {
    example = "true"
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

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  region      = data.aws_region.current.id
  account_id  = data.aws_caller_identity.current.account_id
  bucket_name = format("%s-%s-%s", var.name, local.region, local.account_id)
}
#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3" {
  source = "../../"

  name = var.name
  tags = var.tags
}
output "generic-s3" { value = module.generic-s3 }

module "example-generic-object" {
  source = "../../modules/s3_object_from_file"

  tags = { example = "true" }

  bucket      = module.generic-s3.bucket.name
  file_source = "${path.module}/files/test_file.txt"
  key         = "test_file.txt"
}
output "example-generic-object" { value = module.example-generic-object }
