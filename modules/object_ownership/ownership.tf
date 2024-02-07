resource "aws_s3_bucket_ownership_controls" "ownership" {
  #checkov:skip=CKV2_AWS_65: "AWS S3 bucket access control lists (ACLs) in use" - Since this is a re-usable module, this needs to be able to be overridden. Uses best practice default.

  bucket = var.bucket

  rule {
    object_ownership = var.object_ownership
  }
}
