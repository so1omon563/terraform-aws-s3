locals {

  target_grant_permission = var.target_grant_permission != null ? { "permission" = var.target_grant_permission } : {}

}
