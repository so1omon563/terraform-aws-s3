locals {

  abort_incomplete_multipart_upload_enabled = var.abort_incomplete_multipart_upload != null ? { enabled = var.abort_incomplete_multipart_upload } : {}
  expiration_enabled                        = var.expiration != null ? { enabled = var.expiration } : {}
  filter_enabled                            = var.filter != null ? { enabled = local.filter } : {}
  filter_and_enabled                        = var.filter_and != null ? { enabled = local.filter_and } : {}
  filter_tag_enabled                        = var.filter_tag != null ? { enabled = local.filter_tag } : {}
  noncurrent_version_expiration_enabled     = var.noncurrent_version_expiration != null ? { enabled = var.noncurrent_version_expiration } : {}
  noncurrent_version_transition_enabled     = var.noncurrent_version_transition != null ? { enabled = var.noncurrent_version_transition } : {}
  transition_enabled                        = var.transition != null ? { enabled = var.transition } : {}
  #   rule_enabled                              = var.rule != null ? { enabled = var.rule } : {}

  filter_defaults = {
    object_size_greater_than = null
    object_size_less_than    = null
    prefix                   = null
  }
  filter = merge(local.filter_defaults, var.filter)

  filter_and_defaults = {
    object_size_greater_than = null
    object_size_less_than    = null
    prefix                   = null
    tags                     = null
  }
  filter_and = merge(local.filter_and_defaults, var.filter_and)

  filter_tag_defaults = {
    key   = null
    value = null
  }
  filter_tag = merge(local.filter_tag_defaults, var.filter_tag)
}
