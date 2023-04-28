variable "access_control_policy_grants" {
  description = "Map of values for the grant block of the [access_control_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. See `with_acl_grants` example for usage examples."
  type        = any

  default = []
}

variable "access_control_policy_owner" {
  description = "Map of values for the owner block of the [access_control_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. See `with_acl_grants` example for usage examples."
  type        = map(string)

  default = null
}

variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "canned_acl" {
  type        = string
  description = "The canned ACL to use for the bucket. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options. If you wish to use an `access_control_policy`, this must be set to `null`."
  validation {
    condition = var.canned_acl == null ? true : contains(
      ["private",
        "public-read",
        "public-read-write",
        "authenticated-read",
        "aws-exec-read",
        "bucket-owner-read",
        "bucket-owner-full-control",
      "log-delivery-write"],
    var.canned_acl)
    error_message = "Valid values are limited to (private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, bucket-owner-full-control, log-delivery-write)."
  }
  default = null
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}
