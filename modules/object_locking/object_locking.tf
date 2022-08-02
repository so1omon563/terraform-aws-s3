resource "aws_s3_bucket_object_lock_configuration" "object_locking" {
  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner
  object_lock_enabled   = "Enabled"

  rule {
    default_retention {
      days  = var.object_lock_configuration.days
      mode  = var.object_lock_configuration.mode
      years = var.object_lock_configuration.years
    }
  }
}
