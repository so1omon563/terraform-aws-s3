variable "name" {
  default = "default-s3"
}

variable "tags" {
  default = {
    example = "true"
  }
}
variable "bucket_prefix" {
  default = "prefix"
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
  bucket_name = format("%s-%s-%s-%s", var.name, var.bucket_prefix, local.region, local.account_id)
}
#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-prefix" {
  source = "../../"

  name          = var.name
  tags          = var.tags
  bucket_prefix = var.bucket_prefix
}
output "generic-s3-prefix" { value = module.generic-s3-prefix }
