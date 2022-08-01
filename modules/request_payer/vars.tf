variable "bucket" {
  type        = string
  description = "The name of the bucket."
}

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}

variable "request_payer" {
  description = "Specifies who should bear the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer. See [Requester Pays Buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html) developer guide for more information."
  type        = string
  validation {
    condition     = var.request_payer == null ? true : contains(["BucketOwner", "Requester"], var.request_payer)
    error_message = "Valid values are limited to (BucketOwner, Requester)."
  }
  default = null
}
