resource "aws_s3_bucket_acl" "canned_acl" {
  bucket                = var.bucket
  acl                   = var.canned_acl
  expected_bucket_owner = var.expected_bucket_owner
}

resource "aws_s3_bucket_public_access_block" "generic" {
  count  = var.canned_acl == "private" ? 1 : 0
  bucket = var.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
