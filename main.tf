/**
* Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
*/
terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

module "accelerate" {
  for_each = local.accelerate_status
  source   = "./modules/accelerate"
  bucket   = aws_s3_bucket.generic.id
  status   = each.value
}

module "encryption" {
  source             = "./modules/encryption"
  bucket             = aws_s3_bucket.generic.bucket
  bucket_key_enabled = local.encryption.use_bucket_keys

  kms_master_key_id = var.kms_arn
  sse_algorithm     = local.encryption.use_kms ? "aws:kms" : "AES256"
}

module "logging" {
  for_each = local.s3_logging_bucket
  source   = "./modules/logging"

  bucket        = aws_s3_bucket.generic.bucket
  target_bucket = var.s3_logging_bucket
  target_prefix = local.bucket_name
}

module "oai" {
  depends_on = [
    aws_s3_bucket.generic
  ]
  for_each = local.oai
  source   = "./modules/oai"
  bucket   = aws_s3_bucket.generic.bucket
}

module "request_payer" {
  source                = "./modules/request_payer"
  bucket                = aws_s3_bucket.generic.bucket
  expected_bucket_owner = var.request_payer.expected_bucket_owner
  request_payer         = var.request_payer.request_payer
}

module "versioning" {
  source                = "./modules/versioning"
  bucket                = aws_s3_bucket.generic.bucket
  expected_bucket_owner = var.versioning_configuration.expected_bucket_owner
  mfa_delete            = var.versioning_configuration.mfa_delete
  mfa_device            = var.versioning_configuration.mfa_device
  status                = var.versioning_configuration.status
}
