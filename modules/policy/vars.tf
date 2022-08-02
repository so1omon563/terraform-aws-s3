variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "policy" {
  type        = string
  description = "The text of the policy. Although this is a bucket policy rather than an IAM policy, the [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/tutorials/terraform/aws-iam-policy?_ga=2.150865718.1068941414.1658759740-2145690310.1655932481). Note: Bucket policies are limited to 20 KB in size."
}
