variable "access_control_policy" {
  description = "Map of values for the [access_control_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. If this is set, `canned_acl` must be set to `null`. Note that values are required for all objects, even if the value is `null`."
  type = object({
    grants = list(object({
      grant = object({
        grantee = object({
          email_address = string
          id            = string
          type          = string
          uri           = string
        })
        permission = string
      })
    }))
    owner = object({
      id           = string
      display_name = string
    })
  })
  default = null
}

variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "canned_acl" {
  type        = string
  description = "The canned ACL to use for the bucket. Note that the default is `private`. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options. If you wish to use an `access_control_policy`, this must be set to `null`."
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
  default = "private"
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}
