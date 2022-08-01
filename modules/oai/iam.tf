resource "aws_s3_bucket_policy" "oai" {
  bucket = var.bucket
  policy = data.aws_iam_policy_document.oai.json
}
