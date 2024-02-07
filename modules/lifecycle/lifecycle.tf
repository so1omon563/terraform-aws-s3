resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  #checkov:skip=CKV_AWS_300: "Ensure S3 lifecycle configuration sets period for aborting failed uploads" - Since this is a re-usable module, this needs to be able to be overridden. Default variables meet best practice standard.

  bucket                = var.bucket
  expected_bucket_owner = var.expected_bucket_owner

  rule {

    id     = var.rule.id
    status = var.rule.enabled ? "Enabled" : "Disabled"

    dynamic "abort_incomplete_multipart_upload" {
      for_each = local.abort_incomplete_multipart_upload_enabled
      content {
        days_after_initiation = abort_incomplete_multipart_upload.value.days_after_initiation
      }
    }

    dynamic "expiration" {
      for_each = local.expiration_enabled
      content {
        date                         = expiration.value.date
        days                         = expiration.value.days
        expired_object_delete_marker = expiration.value.expired_object_delete_marker
      }
    }

    dynamic "filter" {
      for_each = local.filter_enabled
      content {
        object_size_greater_than = filter.value.object_size_greater_than
        object_size_less_than    = filter.value.object_size_less_than
        prefix                   = filter.value.prefix

        dynamic "tag" {
          for_each = local.filter_tag_enabled
          content {
            key   = tag.value.key
            value = tag.value.value
          }
        }

        dynamic "and" {
          for_each = local.filter_and_enabled
          content {
            object_size_greater_than = and.value.object_size_greater_than
            object_size_less_than    = and.value.object_size_less_than
            prefix                   = and.value.prefix
            tags                     = and.value.tags
          }
        }
      }
    }

    dynamic "noncurrent_version_expiration" {
      for_each = local.noncurrent_version_expiration_enabled
      content {
        newer_noncurrent_versions = noncurrent_version_expiration.value.newer_noncurrent_versions
        noncurrent_days           = noncurrent_version_expiration.value.noncurrent_days
      }
    }

    dynamic "noncurrent_version_transition" {
      for_each = local.noncurrent_version_transition_enabled
      content {
        newer_noncurrent_versions = noncurrent_version_transition.value.newer_noncurrent_versions
        noncurrent_days           = noncurrent_version_transition.value.noncurrent_days
        storage_class             = noncurrent_version_transition.value.storage_class
      }
    }

    dynamic "transition" {
      for_each = local.transition_enabled
      content {
        date          = transition.value.date
        days          = transition.value.days
        storage_class = transition.value.storage_class
      }
    }
  }
}
