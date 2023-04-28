data "aws_canonical_user_id" "current" {}

module "acl-s3" {
  source  = "so1omon563/s3/aws"
  version = "3.3.0" # Replace with appropriate version

  name          = "example-bucket"
  bucket_prefix = "acl-test"
  tags          = { example = "true" }

  object_ownership = "ObjectWriter"

  access_control_policy_grants = [
    {
      type       = "CanonicalUser"
      permission = "FULL_CONTROL"
      id         = data.aws_canonical_user_id.current.id
    },
    {
      type       = "Group"
      permission = "READ_ACP"
      uri        = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    }
  ]
  access_control_policy_owner = {
    id = data.aws_canonical_user_id.current.id
  }
}

output "acl-s3" { value = module.acl-s3 }
