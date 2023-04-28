locals {
  access_control_policy_grants = try(jsondecode(var.access_control_policy_grants), var.access_control_policy_grants)
}
