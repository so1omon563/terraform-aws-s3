variable "bucket" {
  type        = string
  description = "Name of the bucket to place the file in. Alternatively, an S3 access point ARN can be specified."
}

variable "bucket_key_enabled" {
  type        = bool
  description = "Whether or not to use [Amazon S3 Bucket Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html) for SSE-KMS."
  default     = false
}

variable "cache_control" {
  description = "Specifies caching behavior along the request/reply chain Read [w3c cache_control](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9) for further details."
  type        = string
  default     = null
}

variable "canned_acl" {
  type        = string
  description = "The canned ACL to use for the bucket. Note that the default is `private` by design. See [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) for more information on the options."
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

variable "content_disposition" {
  description = "Specifies presentational information for the object. Read [w3c content_disposition](https://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1) for further information."
  type        = string
  default     = null
}

variable "content_encoding" {
  description = "Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field. Read [w3c content encoding](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11) for further information."
  type        = string
  default     = null
}

variable "content_language" {
  description = "The language the content is in e.g. en-US or en-GB, etc."
  type        = string
  default     = null
}

variable "content_type" {
  description = "A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input."
  type        = string
  default     = null
}

variable "default_master_key" {
  description = "Boolean to determine if the default master key is used. If false, and no kms_arn is provided, AES256 will be used."
  type        = bool
  default     = false
}

variable "file_source" {
  type        = string
  description = "Path to the file to be uploaded"
}

variable "force_destroy" {
  type        = bool
  description = "Whether to allow the object to be deleted by removing any legal hold on any object version. Default is `false`. This value should be set to `true` only if the bucket has S3 object lock enabled."
  default     = false
}

variable "key" {
  type        = string
  description = "The name of the object once it is in the bucket"
}

variable "kms_arn" {
  description = "ARN of the KMS key to encrypt the object with. If not provided, the object will be encrypted with either the Default Master Key, or AES256 by default."
  type        = string
  default     = null
}

variable "object_lock_legal_hold_status" {
  description = "[Legal hold](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html#object-lock-legal-holds) status that you want to apply to the specified object. Valid values are `ON` and `OFF`."
  type        = string
  validation {
    condition     = var.object_lock_legal_hold_status == null ? true : contains(["ON", "OFF"], var.object_lock_legal_hold_status)
    error_message = "Valid values are limited to (ON,OFF)."
  }
  default = null
}

variable "object_lock_mode" {
  description = "Object lock [retention mode](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html#object-lock-retention-modes) that you want to apply to the specified object. Valid values are `GOVERNANCE` and `COMPLIANCE`."
  type        = string
  validation {
    condition     = var.object_lock_mode == null ? true : contains(["GOVERNANCE", "COMPLIANCE"], var.object_lock_mode)
    error_message = "Valid values are limited to (GOVERNANCE,COMPLIANCE)."
  }
  default = null
}

variable "object_lock_retain_until_date" {
  description = "Date and time, in [RFC3339 format](https://www.rfc-editor.org/rfc/rfc3339#section-5.8), when this object's object lock will [expire](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html#object-lock-retention-periods)."
  type        = string
  default     = null
}

variable "storage_class" {
  description = "Specifies the desired Storage Class for the object."
  type        = string
  default     = "STANDARD"
  validation {
    condition = contains([
      "STANDARD",
      "REDUCED_REDUNDANCY",
      "ONEZONE_IA",
      "INTELLIGENT_TIERING",
      "GLACIER",
      "DEEP_ARCHIVE",
      "STANDARD_IA",
    ], var.storage_class)
    error_message = "Valid values are limited to (STANDARD,REDUCED_REDUNDANCY,ONEZONE_IA,INTELLIGENT_TIERING,GLACIER,DEEP_ARCHIVE,STANDARD_IA)."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tag names and values for tags to apply to all taggable resources created by the module. Default value is a blank map to allow for using Default Tags in the provider."
  default     = {}
}

variable "website_redirect" {
  description = "Specifies a target URL for [website redirect](https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-page-redirect.html)."
  type        = string
  default     = null
}
