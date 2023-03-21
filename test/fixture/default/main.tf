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
data "aws_canonical_user_id" "current" {}
module "acl-s3" {
  source = "../../../"

  name          = var.name
  bucket_prefix = "acl-test"
  tags          = { example = "true" }
  canned_acl    = null
  access_control_policy = {
    grants = [{
      grant = {
        grantee = {
          email_address = null
          id            = data.aws_canonical_user_id.current.id
          type          = "CanonicalUser"
          uri           = null
        }
        permission = "READ"
      },

      grant = {
        grantee = {
          email_address = null
          id            = null
          type          = "Group"
          uri           = "http://acs.amazonaws.com/groups/s3/LogDelivery"

        }
        permission = "READ_ACP"
      }
    }]

    owner = {
      id           = data.aws_canonical_user_id.current.id
      display_name = null
    }

  }
  object_ownership = null
}

output "acl-s3" { value = module.acl-s3 }

module "generic-s3" {
  source = "../../../"

  name = var.name
  tags = { example = "true" }
}
output "generic-s3" { value = module.generic-s3 }

module "example-generic-object" {
  source = "../../../modules/s3_object_from_file"

  tags = { example = "true" }

  bucket      = module.generic-s3.bucket.name
  file_source = "${path.module}/files/test_file.txt"
  key         = "test_file.txt"
}
output "example-generic-object" { value = module.example-generic-object }

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-prefix" {
  source = "../../../"

  name          = var.name
  tags          = { example = "true" }
  bucket_prefix = var.bucket_prefix
}
output "generic-s3-prefix" { value = module.generic-s3-prefix }

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-override" {
  source = "../../../"

  name                 = var.name
  tags                 = { example = "true" }
  bucket_name_override = var.bucket_name_override
}
output "generic-s3-override" { value = module.generic-s3-override }

#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "generic-s3-options" {
  source = "../../../"

  name              = format("%s-options", var.name)
  accelerate_status = "Enabled"
  enable_oai        = true
  # s3_logging_bucket = "bucket_name_here"
  tags = { example = "true" }
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
    expired_object_delete_marker = true
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
