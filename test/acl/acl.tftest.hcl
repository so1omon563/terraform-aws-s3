# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_acl_s3_outputs_plan" {
  command = plan
  assert {
    condition     = module.acl-s3.bucket.tags_all.Name == local.bucket_name
    error_message = "Name Tag did not match expected result."
  }
  assert {
    condition     = module.acl-s3.bucket.tags_all.example == "true" && module.acl-s3.bucket.tags_all.environment == "dev" && module.acl-s3.bucket.tags_all.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }
  assert {
    condition     = module.acl-s3.object_ownership_module.enabled.object_ownership.rule[0].object_ownership == "ObjectWriter" && module.acl-s3.object_ownership_module.enabled.object_ownership.bucket == local.bucket_name
    error_message = "Object ownership does not match expected result."
  }
  assert {
    condition     = module.acl-s3.versioning_module.versioning.versioning_configuration[0].status == "Enabled" && module.acl-s3.versioning_module.versioning.bucket == local.bucket_name
    error_message = "Versioning configuration does not match expected result."
  }
  assert {
    condition     = one(module.acl-s3.encryption_module.encryption.rule[*]) != null
    error_message = "Encryption configuration does not match expected result."
  }
  assert {
    condition     = one(module.acl-s3.encryption_module.encryption.rule[*].bucket_key_enabled) == false && module.acl-s3.encryption_module.encryption.bucket == local.bucket_name
    error_message = "Encryption configuration does not match expected result."
  }
  assert {
    condition     = module.acl-s3.logging_module == {}
    error_message = "Logging configuration does not match expected result."
  }
  assert {
    condition     = module.acl-s3.public_access_block_module.public_access_block.block_public_acls == true && module.acl-s3.public_access_block_module.public_access_block.block_public_policy == true && module.acl-s3.public_access_block_module.public_access_block.ignore_public_acls == true && module.acl-s3.public_access_block_module.public_access_block.restrict_public_buckets == true && module.acl-s3.public_access_block_module.public_access_block.bucket == local.bucket_name
    error_message = "Public Access Block configuration does not match expected result."
  }
  assert {
    condition     = module.acl-s3.request_payer_module.request_payer.payer == "BucketOwner" && module.acl-s3.request_payer_module.request_payer.bucket == local.bucket_name
    error_message = "Logging configuration does not match expected result."
  }
  assert {
    condition     = module.acl-s3.access_control_policy_module.enabled.acl.access_control_policy[0] != null
    error_message = "Access Control Policy does not match expected result."
  }
  assert {
    condition     = module.acl-s3.access_control_policy_module.enabled.acl.access_control_policy[0].owner[0].id == data.aws_canonical_user_id.current.id
    error_message = "Access Control Policy does not match expected result."
  }
}
