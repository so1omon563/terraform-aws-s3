resource "aws_s3_bucket_logging" "logging" {
  bucket = var.bucket

  target_bucket = var.target_bucket
  target_prefix = var.target_prefix

  dynamic "target_grant" {
    for_each = local.target_grant_permission
    content {
      grantee {
        email_address = var.grantee_email_address
        id            = var.grantee_id
        type          = var.grantee_type
        uri           = var.grantee_uri
      }
      permission = target_grant.value
    }
  }
}
