resource "aws_s3_bucket_acl" "canned_acl" {
  bucket = aws_s3_bucket.generic.id
  acl    = var.canned_acl
}

resource "aws_s3_bucket_public_access_block" "generic" {
  count  = var.canned_acl == "private" ? 1 : 0
  bucket = aws_s3_bucket.generic.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
