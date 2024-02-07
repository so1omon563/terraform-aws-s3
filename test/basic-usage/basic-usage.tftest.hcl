# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_basic_usage_s3_outputs_plan" {
  command = plan
  assert {
    condition     = module.generic-s3.bucket.tags_all.Name == local.bucket_name
    error_message = "Name Tag did not match expected result."
  }
  assert {
    condition     = module.generic-s3.bucket.tags_all.example == "true" && module.generic-s3.bucket.tags_all.environment == "dev" && module.generic-s3.bucket.tags_all.terraform == "true"
    error_message = "One or more tags did not match expected result."
  }
  assert {
    condition     = module.generic-s3.object_ownership_module.enabled.object_ownership.rule[0].object_ownership == "BucketOwnerEnforced" && module.generic-s3.object_ownership_module.enabled.object_ownership.bucket == local.bucket_name
    error_message = "Object ownership does not match expected result."
  }
  assert {
    condition     = module.generic-s3.versioning_module.versioning.versioning_configuration[0].status == "Enabled" && module.generic-s3.versioning_module.versioning.bucket == local.bucket_name
    error_message = "Versioning configuration does not match expected result."
  }
  assert {
    condition     = one(module.generic-s3.encryption_module.encryption.rule[*]) != null
    error_message = "Encryption configuration does not match expected result."
  }
  assert {
    condition     = one(module.generic-s3.encryption_module.encryption.rule[*].bucket_key_enabled) == false && module.generic-s3.encryption_module.encryption.bucket == local.bucket_name
    error_message = "Encryption configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3.logging_module == {}
    error_message = "Logging configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3.public_access_block_module.public_access_block.block_public_acls == true && module.generic-s3.public_access_block_module.public_access_block.block_public_policy == true && module.generic-s3.public_access_block_module.public_access_block.ignore_public_acls == true && module.generic-s3.public_access_block_module.public_access_block.restrict_public_buckets == true && module.generic-s3.public_access_block_module.public_access_block.bucket == local.bucket_name
    error_message = "Public Access Block configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3.request_payer_module.request_payer.payer == "BucketOwner" && module.generic-s3.request_payer_module.request_payer.bucket == local.bucket_name
    error_message = "Logging configuration does not match expected result."
  }
  assert {
    condition     = module.example-generic-object.bucket-object.acl == "private" && module.example-generic-object.bucket-object.bucket == local.bucket_name && module.example-generic-object.bucket-object.server_side_encryption == "AES256" && module.example-generic-object.bucket-object.key == "test_file.txt"
    error_message = "Bucket Object configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3.access_control_policy_module == {}
    error_message = "Access Control Policy does not match expected result."
  }
}
