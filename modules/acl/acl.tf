resource "aws_s3_bucket_acl" "acl" {
  bucket = var.bucket
  acl    = var.canned_acl

  dynamic "access_control_policy" {
    for_each = local.access_control_policy

    content {
      dynamic "grant" {
        for_each = access_control_policy.value.grants

        content {
          grantee {
            email_address = grant.value.grant.grantee.email_address
            id            = grant.value.grant.grantee.id
            type          = grant.value.grant.grantee.type
            uri           = grant.value.grant.grantee.uri
          }
          permission = grant.value.grant.permission

        }
      }
      owner {
        id           = access_control_policy.value.owner.id
        display_name = access_control_policy.value.owner.display_name
      }
    }
  }
  expected_bucket_owner = var.expected_bucket_owner
}
