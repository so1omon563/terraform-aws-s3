variable "accelerate_status" {
  description = "Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`."
  type        = string
  validation {
    condition     = var.accelerate_status == null ? true : contains(["Enabled", "Suspended"], var.accelerate_status)
    error_message = "Valid values are limited to (Enabled, Suspended)."
  }
  default = null
}

variable "access_control_policy_grants" {
  description = "Map of values for the grant block of the [access_control_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. May also conflict with `object_ownership`. See that variable for more information. See `with_acl_grants` example for usage examples."
  type        = any

  default = []
}

variable "access_control_policy_owner" {
  description = "Map of values for the owner block of the [access_control_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl#access_control_policy) attribute. Conflicts with `canned_acl`. May also conflict with `object_ownership`. See that variable for more information. See `with_acl_grants` example for usage examples."
  type        = map(string)

  default = null
}

variable "bucket_name_override" {
  description = "Used if there is a need to specify a bucket name outside of the standardized nomenclature. For example, if importing a bucket that doesn't follow the standard naming formats."
  type        = string
  default     = null
}

variable "bucket_policy" {
  description = "Optional bucket policy in JSON format. Although this is a bucket policy rather than an IAM policy, the [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the [AWS IAM Policy Document Guide](https://learn.hashicorp.com/tutorials/terraform/aws-iam-policy?_ga=2.150865718.1068941414.1658759740-2145690310.1655932481). Note: Bucket policies are limited to 20 KB in size."
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "Bucket name prefix, will be pre-pended to AWS account ID and region to make bucket unique"
  type        = string
  default     = null
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

variable "cors_rules" {
  description = "Map of properties for optional CORS rules. See [aws_s3_bucket_cors_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) for more info. Note that values are required for all objects, even if the value is `null`."
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    id              = string
    max_age_seconds = number
  }))
  default = null
}

variable "enable_oai" {
  description = "If this is set to `true`, an [Origin Access Identity](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) for use with CloudFront."
  type        = bool
  default     = false
}

variable "encryption" {
  type        = map(string)
  description = <<EOT
  Can be used to override the values in `local.encryption_defaults`.

  If `use_kms` is set to false, the bucket will be encrypted using the default `AES256` algorithm.

  If `use_bucket_keys` is set to `true`, a dedicated bucket key will be enabled, as outlined [here](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html).

  Default local values are:

```
  encryption_defaults = {
    use_kms         = true
    use_bucket_keys = false
  }
```
EOT
  default     = null
}

variable "force_destroy" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "kms_arn" {
  description = "ARN of the KMS key to encrypt the bucket with. If no value is provided, and the `encryption.use_kms` variable is set to `true`, the bucket will be encrypted using the default `aws/s3` AWS KMS master key."
  type        = string
  default     = null
}

variable "lb_access_logs" {
  description = "Should the bucket be able to be used as an access log bucket for an ELB? If set to `true`, the bucket will be configured to allow access from the ELB service principal."
  type        = bool
  default     = false
}

variable "lifecycle_abort_incomplete_multipart_upload" {
  description = "Specifies the days since the initiation of an incomplete multipart upload that Amazon S3 will wait before permanently removing all parts of the upload. For more information, see [Aborting Incomplete Multipart Uploads Using a Bucket Lifecycle Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config) in the Amazon Simple Storage Service Developer Guide. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    days_after_initiation = number
  })
  default = null
}

variable "lifecycle_expiration" {
  description = "Specifies when an object transitions to a specified storage class. See [Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#expiration) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    date                         = string
    days                         = number
    expired_object_delete_marker = bool
  })
  default = null
}

variable "lifecycle_filter" {
  description = "Specifies a filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info."
  type        = map(string)
  default     = null
}

variable "lifecycle_filter_and" {
  description = "Specifies a logical AND to two or more predicates for the filter. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info."
  type        = map(string)
  default     = null
}

variable "lifecycle_filter_tag" {
  description = "Specifies a tag in the filter for identifying objects that a lifecycle rule applies to. See [Filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#filter) for more info."
  type        = map(string)
  default     = null
}

variable "lifecycle_noncurrent_version_expiration" {
  description = "Specifies when noncurrent objects expires. See [Noncurrent Version Expiration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_expiration) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    newer_noncurrent_versions = number
    noncurrent_days           = number
  })
  default = null
}

variable "lifecycle_noncurrent_version_transition" {
  description = "Specifies when noncurrent object versions transition to a specified storage class. See [Noncurrent Version Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#noncurrent_version_transition) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    newer_noncurrent_versions = number
    noncurrent_days           = number
    storage_class             = string
  })
  default = null
}

variable "lifecycle_rule" {
  description = "Properties for an optional lifecycle rule. See [aws_s3_bucket_lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    id      = string
    enabled = bool
  })
  default = null
}

variable "lifecycle_transition" {
  description = "Specifies when an object transitions to a specified storage class. See [Transition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration#transition) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    date          = string
    days          = number
    storage_class = string
  })
  default = null
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix. Either this variable, or `bucket_name_override` must be set."
  default     = null
}

variable "object_lock_configuration" {
  description = "Map of properties for an optional object lock configuration. See [Object Lock Configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) for more info. If using this variable, all values must be populated, even if that value is `null`."
  type = object({
    days  = number
    mode  = string
    years = number
  })
  validation {
    condition     = var.object_lock_configuration == null ? true : contains(["COMPLIANCE", "GOVERNANCE"], var.object_lock_configuration.mode)
    error_message = "Valid values for mode are limited to (COMPLIANCE, GOVERNANCE)."
  }
  default = null
}

variable "object_ownership" {
  type        = string
  description = "Object ownership. Valid values: `BucketOwnerPreferred`, `ObjectWriter` or `BucketOwnerEnforced`. If ACLs (canned or otherwise) are required, then `BucketOwnerPreferred`, or `ObjectWriter` must be used. See [s3_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) for more information on the options."
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

variable "public_access_block" {
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  description = "Public Access Block configuration. See [s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) for more information on the options."
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}

variable "request_payer" {
  description = "Specifies who should bear the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer. See [Requester Pays Buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html) developer guide for more information."
  type        = map(string)
  default = {
    expected_bucket_owner = null
    request_payer         = "BucketOwner"
  }
}

variable "s3_logging_bucket" {
  description = "The name of the S3 bucket to log S3 access to. Will be passed to the `logging` submodule. If not provided, logging will be disabled. For additional logging options, bypass this variable, and call the submodule directly."
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "versioning_configuration" {
  type        = map(string)
  description = "A map of versioning configuration for the bucket. Will be passed to the `versioning` submodule. Please see documentation for that submodule for more information on valid entries."
  default = {
    expected_bucket_owner = null
    mfa_delete            = "Disabled"
    mfa_device            = null
    status                = "Enabled"
  }
}
