data "aws_canonical_user_id" "current" {}
module "acl-s3" {
  source = "../../"

  name          = "example-bucket"
  bucket_prefix = "acl-test"
  tags          = { example = "true" }
  canned_acl    = null
  access_control_policy = {
    grants = [{
      grant = {
        grantee = {
          email_address = null
          id            = data.aws_canonical_user_id.current.id
          type          = "CanonicalUser"
          uri           = null
        }
        permission = "READ"
      },

      grant = {
        grantee = {
          email_address = null
          id            = null
          type          = "Group"
          uri           = "http://acs.amazonaws.com/groups/s3/LogDelivery"

        }
        permission = "READ_ACP"
      }
    }]

    owner = {
      id           = data.aws_canonical_user_id.current.id
      display_name = null
    }

  }
}

output "acl-s3" { value = module.acl-s3 }
