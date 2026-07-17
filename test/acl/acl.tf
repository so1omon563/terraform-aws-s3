terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 6.0"
    }
  }
}

variable "name" {
  type    = string
  default = "basic-usage-default-s3"
}
variable "bucket_prefix" {
  type    = string
  default = "acl-test"
}

variable "tags" {
  type = map(string)
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
data "aws_canonical_user_id" "current" {}

locals {
  region     = data.aws_region.current.id
  account_id = data.aws_caller_identity.current.account_id
  # Consumed by acl.tftest.hcl, which TFLint does not trace.
  # tflint-ignore: terraform_unused_declarations
  bucket_name = format("%s-%s-%s-%s", var.name, var.bucket_prefix, local.region, local.account_id)
}
#tfsec:ignore:AWS002 Not logging by default. Tests verify that logging is not enabled.
module "acl-s3" {
  source = "../../"

  name          = var.name
  bucket_prefix = "acl-test"
  tags          = var.tags
  access_control_policy_grants = [
    {
      type       = "CanonicalUser"
      permission = "READ"
      id         = data.aws_canonical_user_id.current.id
    },
    {
      type       = "Group"
      permission = "READ_ACP"
      uri        = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    }
  ]
  access_control_policy_owner = {
    id = data.aws_canonical_user_id.current.id
  }
  object_ownership = "ObjectWriter"
}

output "acl-s3" { value = module.acl-s3 }
