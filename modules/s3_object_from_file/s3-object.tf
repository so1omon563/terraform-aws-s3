resource "aws_s3_object" "object" {
  bucket                 = var.bucket
  acl                    = var.canned_acl
  key                    = var.key
  source                 = var.file_source
  bucket_key_enabled     = var.bucket_key_enabled
  kms_key_id             = var.kms_arn != null ? var.kms_arn : null                  # Uses kms key if provided.
  server_side_encryption = var.kms_arn == null ? local.server_side_encryption : null # Uses Server Side Encryption if no KMS Key is provided.

  metadata = {
    sha256 = filesha256(var.file_source) # Used to trigger updates if the file changes
  }

  force_destroy = var.force_destroy
  object_lock_legal_hold_status = var.object_lock_legal_hold_status
  object_lock_mode              = var.object_lock_mode
  object_lock_retain_until_date = var.object_lock_retain_until_date

  storage_class       = var.storage_class
  cache_control       = var.cache_control
  content_disposition = var.content_disposition
  content_encoding    = var.content_encoding
  content_language    = var.content_language
  content_type        = var.content_type

  tags = local.tags
}
