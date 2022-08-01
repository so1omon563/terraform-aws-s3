variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "bucket_key_enabled" {
  type        = bool
  description = "Specifies whether Amazon S3 should use an S3 Bucket Key for object encryption with server-side encryption using AWS KMS (SSE-KMS)."
  default     = false
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}

variable "sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
  default     = "aws:kms"
}

variable "kms_master_key_id" {
  type        = string
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default `aws/s3` AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`."
  default     = null
}
