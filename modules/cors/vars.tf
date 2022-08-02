variable "bucket" {
  type        = string
  description = "The name of the bucket."
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

variable "expected_bucket_owner" {
  type        = string
  description = "The account ID of the expected bucket owner."
  default     = null
}
