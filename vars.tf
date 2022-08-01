variable "accelerate_status" {
  description = "Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`."
  type        = string
  validation {
    condition     = var.accelerate_status == null ? true : contains(["Enabled", "Suspended"], var.accelerate_status)
    error_message = "Valid values are limited to (Enabled, Suspended)."
  }
  default = null
}

variable "bucket_name_override" {
  description = "Used if there is a need to specify a bucket name outside of the standardized nomenclature. For example, if importing a bucket that doesn't follow the standard naming formats."
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
  description = "The canned ACL to use for the bucket. Note that the default is `private`, which will also add a public access block to the bucket."
  validation {
    condition = contains(["private",
      "public-read",
      "public-read-write",
      "authenticated-read",
      "aws-exec-read",
      "bucket-owner-read",
    "bucket-owner-full-control"], var.canned_acl)
    error_message = "Valid values are limited to (private, public-read, public-read-write, authenticated-read, aws-exec-read, bucket-owner-read, bucket-owner-full-control)."
  }
  default = "private"
}

variable "cors_rules" {
  description = "Map of properties for an optional CORS rule. See [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) for more info. Note that values are required for all objects, even if the value is `null`."
  type = list(object({
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
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

variable "lifecycle_rule" {
  description = "Map of properties for an optional lifecycle rule. See [aws_s3_bucket_lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) for more info. Note that values are required for all objects, even if the value is `null`."
  type = list(object({
    id                                     = string
    enabled                                = bool
    abort_incomplete_multipart_upload_days = string
    filter = object({
      prefix = string
    })
    expiration = list(object({
      date                         = string
      days                         = number
      expired_object_delete_marker = string
    }))
    transition = list(object({
      date          = string
      days          = number
      storage_class = string
    }))
    noncurrent_version_transition = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_expiration = list(object({
      days = number
    }))
  }))
  default = null
}

variable "name" {
  type        = string
  description = "Short, descriptive name of the environment. All resources will be named using this value as a prefix."
}

variable "replication_configuration" {
  description = "Map of properties for an optional set of replication rules. See [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) for more info. Note that values are required for all objects, even if the value is `null`."
  type = list(object({
    role = string
    rules = list(object({
      id     = string
      prefix = string
      status = string
      destination = list(object({
        bucket             = string
        storage_class      = string
        replica_kms_key_id = string
        account_id         = string
        access_control_translation = list(object({
          owner = string
        }))
      }))
      source_selection_criteria = list(object({
        enabled = string
      }))
    }))
  }))
  default = null
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
