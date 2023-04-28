resource "aws_s3_bucket_acl" "acl" {
  bucket                = var.bucket
  acl                   = var.canned_acl
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "access_control_policy" {
    for_each = length(local.access_control_policy_grants) > 0 ? [true] : []

    content {
      dynamic "grant" {
        for_each = local.access_control_policy_grants

        content {
          grantee {
            email_address = try(grant.value.email_address, null)
            id            = try(grant.value.id, null)
            type          = grant.value.type
            uri           = try(grant.value.uri, null)
          }
          permission = grant.value.permission

        }
      }
      owner {
        id           = try(var.access_control_policy_owner.id, data.aws_canonical_user_id.current.id)
        display_name = try(var.access_control_policy_owner.display_name, null)
      }

    }
  }
}
