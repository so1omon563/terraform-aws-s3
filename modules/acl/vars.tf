variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "canned_acl" {
  type        = string
  description = "The canned ACL to use for the bucket. Note that the default is `private`, which will also add a (public access block)[https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block] to the bucket. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options."
  validation {
    condition = contains(["private",
      "public-read",
      "public-read-write",
      "authenticated-read",
      "aws-exec-read",
      "bucket-owner-read",
      "bucket-owner-full-control",
    "log-delivery-write"], var.canned_acl)
    error_message = "Valid values are limited to (private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, bucket-owner-full-control, log-delivery-write)."
  }
  default = "private"
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}
