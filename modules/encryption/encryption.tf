resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.kms_master_key_id
    }
    bucket_key_enabled = var.bucket_key_enabled
  }
}
