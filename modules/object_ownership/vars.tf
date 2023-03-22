variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "object_ownership" {
  type        = string
  description = "Object ownership. Valid values: `BucketOwnerPreferred`, `ObjectWriter` or `BucketOwnerEnforced`. See [s3_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) for more information on the options."
  validation {
    condition = var.object_ownership == null ? true : contains(
      ["BucketOwnerPreferred",
        "ObjectWriter",
        "BucketOwnerEnforced",
      ],
    var.object_ownership)
    error_message = "Valid values are limited to (BucketOwnerPreferred, ObjectWriter, BucketOwnerEnforced)."
  }
  default = "BucketOwnerEnforced"
}
