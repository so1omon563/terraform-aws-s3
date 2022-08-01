variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}

variable "status" {
  description = "Sets the the transfer acceleration state of the bucket. Can be `Enabled` or `Suspended`."
  type        = string
  validation {
    condition     = var.status == null ? true : contains(["Enabled", "Suspended"], var.status)
    error_message = "Valid values are limited to (Enabled, Suspended)."
  }
  default = null
}
