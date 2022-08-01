resource "aws_s3_bucket_request_payment_configuration" "payer" {
  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner
  payer                 = var.request_payer
}
