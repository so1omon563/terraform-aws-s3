variable "abort_incomplete_multipart_upload" {
  description = "Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see [Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the Amazon Simple Storage Service Developer Guide. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    days_after_initiation = number
  })
  default = {
    days_after_initiation = 7
  }
}

variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}

variable "expiration" {
  description = "Specifies when an object transitions to a specified storage class. See [Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#expiration) for more info. If using this variable, all values must be populated, even if that value is `null`. If setting `days` or `date`, `expired_object_delete_marker` must be set to `null`."
  type = object({
    date                         = string
    days                         = number
    expired_object_delete_marker = bool
  })
  default = null
}

variable "filter" {
  description = "Specifies a filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type        = map(string)
  default     = null
}

variable "filter_and" {
  description = "Specifies a logical AND to two or more predicates for the filter. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type        = map(string)
  default     = null
}

variable "filter_tag" {
  description = "Specifies a tag in the filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type        = map(string)
  default     = null
}

variable "noncurrent_version_expiration" {
  description = "Specifies when noncurrent objects expires. See [Noncurrent Version Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_expiration) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    newer_noncurrent_versions = number
    noncurrent_days           = number
  })
  default = null
}

variable "noncurrent_version_transition" {
  description = "Specifies when noncurrent object versions transition to a specified storage class. See [Noncurrent Version Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_transition) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    newer_noncurrent_versions = number
    noncurrent_days           = number
    storage_class             = string
  })
  default = null
}

variable "rule" {
  description = "Properties for an optional lifecycle rule. See [aws_s3_bucket_lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    id      = string
    enabled = bool
  })
  default = null
}

variable "transition" {
  description = "Specifies when an object transitions to a specified storage class. See [Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#transition) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    date          = string
    days          = number
    storage_class = string
  })
  default = null
}
