variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}

variable "mfa_delete" {
  type        = string
  description = "Specifies whether MFA delete is enabled in the bucket."
  validation {
    condition = contains(["Enabled",
    "Disabled"], var.mfa_delete)
    error_message = "Valid values are limited to (Enabled, Disabled)."
  }
  default = "Disabled"
}

variable "mfa_device" {
  type        = string
  description = "Required if `versioning_configuration` `mfa_delete` is enabled) The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device."
  default     = null
}


variable "status" {
  type        = string
  description = "The versioning state of the bucket. Valid values: `Enabled`, `Suspended`, or `Disabled`. `Disabled` should only be used when creating or importing resources that correspond to unversioned S3 buckets."
  validation {
    condition = contains(["Enabled",
      "Suspended",
    "Disabled"], var.status)
    error_message = "Valid values are limited to (Enabled, Suspended, Disabled)."
  }
  default = "Enabled"
}
