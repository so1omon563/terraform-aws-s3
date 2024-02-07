resource "aws_s3_bucket" "generic" {
  #checkov:skip=CKV_AWS_18: "Ensure that S3 buckets are encrypted with KMS by default" - Since this is a re-usable module, this needs to be able to be overridden. Uses AWS KMS encryption by default.
  #checkov:skip=CKV_AWS_19: "Ensure all data stored in the S3 bucket is securely encrypted at rest" - Since this is a re-usable module, this needs to be able to be overridden. Uses AWS KMS encryption by default.
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled" - Since this is a re-usable module, this needs to be able to be overridden. Versioning is enabled by default.
  #checkov:skip=CKV2_AWS_61: "Ensure that an S3 bucket has a lifecycle configuration" - Since this is a re-usable module, this needs to be able to be overridden. Includes default rule for aborting failed uploads
  #checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default" - Since this is a re-usable module, this needs to be able to be overridden. Buckets are encrypted by default.
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block" - Since this is a re-usable module, this needs to be able to be overridden. Has one by default.
  #checkov:skip=CKV2_AWS_62: "Ensure S3 buckets should have event notifications enabled" - This is outside the scope of the module. Event notification should handled separately, according to the user's needs.
  bucket              = local.bucket_name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_configuration != null ? true : false
  tags                = merge({ "Name" = local.bucket_name }, local.tags)

}
