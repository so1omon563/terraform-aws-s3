variable "tags" {
  default = {
    example = "true"
  }
}
variable "bucket_name_override" {
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
  bucket_name = var.bucket_name_override
}

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-override" {
  source = "../../"

  tags                 = { example = "true" }
  bucket_name_override = var.bucket_name_override
}
output "generic-s3-override" { value = module.generic-s3-override }
