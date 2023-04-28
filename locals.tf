locals {
  tags       = var.tags
  region     = data.aws_region.current.id
  account_id = data.aws_caller_identity.current.account_id

  encryption_defaults = {
    use_kms         = true
    use_bucket_keys = false
  }
  encryption = merge(local.encryption_defaults, var.encryption)

  access_control_policy_grants = var.access_control_policy_grants != [] ? { enabled = var.access_control_policy_grants } : {}
  accelerate_status            = var.accelerate_status != null ? { enabled = var.accelerate_status } : {}
  bucket_policy                = var.bucket_policy != null ? { enabled = var.bucket_policy } : {}
  canned_acl                   = var.canned_acl != null ? { enabled = var.canned_acl } : {}
  lb_access_logs               = var.lb_access_logs ? { enabled = var.lb_access_logs } : {}
  cors_rules                   = var.cors_rules != null ? { enabled = var.cors_rules } : {}
  lifecycle_rule               = var.lifecycle_rule != null ? { enabled = var.lifecycle_rule } : {}
  oai                          = var.enable_oai ? { enabled = "ignore" } : {}
  object_lock_configuration    = var.object_lock_configuration != null ? { enabled = var.object_lock_configuration } : {}
  object_ownership             = var.object_ownership != null ? { enabled = var.object_ownership } : {}
  s3_logging_bucket            = var.s3_logging_bucket != null ? { enabled = var.s3_logging_bucket } : {}

  bucket_name = var.bucket_name_override != null ? var.bucket_name_override : var.bucket_prefix == null ? format("%s-%s-%s", var.name, local.region, local.account_id) : format("%s-%s-%s-%s", var.name, var.bucket_prefix, local.region, local.account_id)
}
