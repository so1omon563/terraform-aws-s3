resource "aws_s3_bucket_policy" "policy" {
  bucket = var.bucket
  policy = var.policy
}
