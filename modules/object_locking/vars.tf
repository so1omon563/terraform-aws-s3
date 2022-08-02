variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
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
    condition     = contains(["COMPLIANCE", "GOVERNANCE"], var.object_lock_configuration.mode)
    error_message = "Valid values for mode are limited to (COMPLIANCE, GOVERNANCE)."
  }
}
