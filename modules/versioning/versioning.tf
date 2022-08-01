resource "aws_s3_bucket_versioning" "versioning" {
  bucket = var.bucket

  versioning_configuration {
    mfa_delete = var.mfa_delete
    status     = var.status
  }

  expected_bucket_owner = var.expected_bucket_owner

  mfa = var.mfa_device
}
