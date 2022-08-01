resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = format("%s-origin", var.bucket)
}
