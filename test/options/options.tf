variable "name" {
  default = "default-s3"
}

variable "tags" {
  default = {
    example = "true"
  }
}
variable "bucket_prefix" {
  default = "options"
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
module "generic-s3-options" {
  source = "../../"

  name                         = var.name
  bucket_prefix                = var.bucket_prefix
  accelerate_status            = "Enabled"
  enable_oai                   = true
  public_access_block_required = false
  tags                         = var.tags
  lifecycle_rule = {
    id      = "config"
    enabled = true
  }
  lifecycle_abort_incomplete_multipart_upload = {
    days_after_initiation = 10
  }
  lifecycle_expiration = {
    date                         = null
    days                         = 365
    expired_object_delete_marker = null
  }
  lifecycle_filter = {
    object_size_greater_than = null
    object_size_less_than    = null
    prefix                   = "config/"
  }
  lifecycle_noncurrent_version_expiration = {
    newer_noncurrent_versions = 1
    noncurrent_days           = 365
  }
  lifecycle_noncurrent_version_transition = {
    newer_noncurrent_versions = 1
    noncurrent_days           = 60
    storage_class             = "GLACIER"
  }
  lifecycle_transition = {
    date          = null
    days          = 180
    storage_class = "GLACIER"
  }
  cors_rules = [{
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    id              = null
    max_age_seconds = 3000
    },
    {
      allowed_headers = null
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
      expose_headers  = null
      id              = "test"
      max_age_seconds = 3000
  }]
}


output "generic-s3-options" { value = module.generic-s3-options }
