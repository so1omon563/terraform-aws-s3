locals {
  access_control_policy = var.access_control_policy != null ? { enabled = var.access_control_policy } : {}
}
