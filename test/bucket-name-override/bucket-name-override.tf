terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

variable "tags" {
  type = map(string)
  default = {
    example = "true"
  }
}
variable "bucket_name_override" {
  type    = string
  default = "override-default-s3"
}

provider "aws" {
  default_tags {
    tags = {
      environment = "dev"
      terraform   = "true"
    }
  }
}

locals {
  # Consumed by bucket-name-override.tftest.hcl, which TFLint does not trace.
  # tflint-ignore: terraform_unused_declarations
  bucket_name = var.bucket_name_override
}

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-override" {
  source = "../../"

  tags                 = var.tags
  bucket_name_override = var.bucket_name_override
}
output "generic-s3-override" { value = module.generic-s3-override }
