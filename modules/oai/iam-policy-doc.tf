data "aws_iam_policy_document" "oai" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [format("%s/*", data.aws_s3_bucket.bucket.arn)]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [data.aws_s3_bucket.bucket.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}
