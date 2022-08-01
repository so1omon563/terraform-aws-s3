variable "name" {}

variable "tags" {}
variable "bucket_prefix" {}
variable "bucket_name_override" {}

provider "aws" {
  default_tags {
    tags = var.tags
  }
}

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3" {
  source = "../../../"

  name = var.name
  tags = { example = "true" }
}
output "generic-s3" { value = module.generic-s3 }

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
# module "generic-s3-prefix" {
#   source = "../../../"

#   name          = var.name
#   tags          = { example = "true" }
#   bucket_prefix = var.bucket_prefix
# }
# output "generic-s3-prefix" { value = module.generic-s3-prefix }

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
# module "generic-s3-override" {
#   source = "../../../"

#   name                 = var.name
#   tags                 = { example = "true" }
#   bucket_name_override = var.bucket_name_override
# }
# output "generic-s3-override" { value = module.generic-s3-override }

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-options" {
  source = "../../../"

  name              = format("%s-options", var.name)
  accelerate_status = "Enabled"
  enable_oai        = true
  s3_logging_bucket = "prsn-s3-access-logs-us-east-1-498530135067"
  tags              = { example = "true" }
}
output "generic-s3-options" { value = module.generic-s3-options }
