variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}

variable "target_bucket" {
  description = "The name of the S3 bucket to log S3 access to."
  type        = string
}

variable "target_grant_permission" {
  description = "Logging permissions assigned to the grantee for the bucket. Valid values: `FULL_CONTROL`, `READ`, `WRITE`."
  type        = string
  validation {
    condition     = var.target_grant_permission == null ? true : contains(["FULL_CONTROL", "READ", "WRITE"], var.target_grant_permission)
    error_message = "Valid values are limited to (FULL_CONTROL, READ, WRITE)."
  }
  default = null
}

variable "target_prefix" {
  description = "A prefix for all log object keys."
  type        = string
}

variable "grantee_email_address" {
  description = "Email address of the grantee. See [Regions and Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) for supported AWS regions where this argument can be specified."
  type        = string
  default     = null
}

variable "grantee_id" {
  description = "The canonical user ID of the grantee."
  type        = string
  default     = null
}

variable "grantee_type" {
  description = "Type of grantee. Valid values: `CanonicalUser`, `AmazonCustomerByEmail`, `Group`."
  type        = string
  validation {
    condition     = var.grantee_type == null ? true : contains(["CanonicalUser", "AmazonCustomerByEmail", "Group"], var.grantee_type)
    error_message = "Valid values are limited to (CanonicalUser, AmazonCustomerByEmail, Group)."
  }
  default = null
}

variable "grantee_uri" {
  description = "URI of the grantee group."
  type        = string
  default     = null
}
