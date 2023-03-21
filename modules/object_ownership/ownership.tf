resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = var.bucket

  rule {
    object_ownership = var.object_ownership
  }
}
