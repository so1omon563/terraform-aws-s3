# resource "aws_s3_bucket_cors_configuration" "cors" {
#   count  = var.cors_rules == null ? 0 : 1
#   bucket = aws_s3_bucket.generic.id

#   dynamic "cors_rule" {
#     for_each = var.cors_rules == null ? [] : var.cors_rules

#     content {
#       allowed_headers = cors_rule.value.allowed_headers
#       allowed_methods = cors_rule.value.allowed_methods
#       allowed_origins = cors_rule.value.allowed_origins
#       expose_headers  = cors_rule.value.expose_headers
#       max_age_seconds = cors_rule.value.max_age_seconds
#     }
#   }
# }
