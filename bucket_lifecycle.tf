# resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
#   count  = var.lifecycle_rule == null ? 0 : 1
#   bucket = aws_s3_bucket.generic.id

#   dynamic "rule" {
#     for_each = var.lifecycle_rule == null ? [] : var.lifecycle_rule

#     content {
#       id     = rule.value.id
#       status = rule.value.enabled ? "Enabled" : "Disabled"

#       dynamic "abort_incomplete_multipart_upload" {
#         for_each = rule.value.abort_incomplete_multipart_upload == null ? [] : rule.value.abort_incomplete_multipart_upload

#         content {
#           days_after_initiation = abort_incomplete_multipart_upload.value
#         }
#       }

#       dynamic "filter" {
#         for_each = rule.value.filter == null ? [] : rule.value.filter

#         content {
#           prefix = filter.value.prefix
#         }
#       }

#       dynamic "expiration" {
#         for_each = rule.value.expiration == null ? [] : rule.value.expiration

#         content {
#           date                         = expiration.value.date
#           days                         = expiration.value.days
#           expired_object_delete_marker = expiration.value.expired_object_delete_marker
#         }
#       }

#       dynamic "transition" {
#         for_each = rule.value.transition == null ? [] : rule.value.transition

#         content {
#           date          = transition.value.date
#           days          = transition.value.days
#           storage_class = transition.value.storage_class
#         }
#       }

#       dynamic "noncurrent_version_transition" {
#         for_each = rule.value.noncurrent_version_transition == null ? [] : rule.value.noncurrent_version_transition

#         content {
#           noncurrent_days = noncurrent_version_transition.value.days
#           storage_class   = noncurrent_version_transition.value.storage_class
#         }
#       }

#       dynamic "noncurrent_version_expiration" {
#         for_each = rule.value.noncurrent_version_expiration == null ? [] : rule.value.noncurrent_version_expiration

#         content {
#           noncurrent_days = noncurrent_version_expiration.value.days
#         }
#       }
#     }
#   }
# }
