mock_provider "aws" {
  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
    }
  }

  mock_data "aws_region" {
    defaults = {
      id   = "us-east-1"
      name = "us-east-1"
    }
  }

  mock_data "aws_elb_service_account" {
    defaults = {
      id = "127311923021"
    }
  }
}

# Some basic unit testing to verify that selected outputs of the main module return expected results.
# In order to reduce testing cost, only items that can be verified via a `terraform plan` are being tested here.

run "verify_name_override_s3_outputs_plan" {
  command = plan
  assert {
    condition     = module.generic-s3-override.bucket.tags.Name == local.bucket_name
    error_message = "Name Tag did not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.bucket.tags.example == "true"
    error_message = "One or more tags did not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.object_ownership_module.enabled.object_ownership.rule[0].object_ownership == "BucketOwnerEnforced" && module.generic-s3-override.object_ownership_module.enabled.object_ownership.bucket == local.bucket_name
    error_message = "Object ownership does not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.versioning_module.versioning.versioning_configuration[0].status == "Enabled" && module.generic-s3-override.versioning_module.versioning.bucket == local.bucket_name
    error_message = "Versioning configuration does not match expected result."
  }
  assert {
    condition     = one(module.generic-s3-override.encryption_module.encryption.rule[*]) != null
    error_message = "Encryption configuration does not match expected result."
  }
  assert {
    condition     = one(module.generic-s3-override.encryption_module.encryption.rule[*].bucket_key_enabled) == false && module.generic-s3-override.encryption_module.encryption.bucket == local.bucket_name
    error_message = "Encryption configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.logging_module == {}
    error_message = "Logging configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.public_access_block_module.enabled.public_access_block.block_public_acls == true && module.generic-s3-override.public_access_block_module.enabled.public_access_block.block_public_policy == true && module.generic-s3-override.public_access_block_module.enabled.public_access_block.ignore_public_acls == true && module.generic-s3-override.public_access_block_module.enabled.public_access_block.restrict_public_buckets == true && module.generic-s3-override.public_access_block_module.enabled.public_access_block.bucket == local.bucket_name
    error_message = "Public Access Block configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.request_payer_module.request_payer.payer == "BucketOwner" && module.generic-s3-override.request_payer_module.request_payer.bucket == local.bucket_name
    error_message = "Logging configuration does not match expected result."
  }
  assert {
    condition     = module.generic-s3-override.access_control_policy_module == {}
    error_message = "Access Control Policy does not match expected result."
  }
}
