#tfsec:ignore:AWS002 Code allows for not enabling logging by design - for deploying into an account that doesn't have logging buckets created.
#tfsec:ignore:aws-s3-enable-bucket-encryption Encryption configuration is separate. Note that this module forces encryption to be enabled. See the `encryption` variable.
#tfsec:ignore:aws-s3-encryption-customer-key This module uses KMS encryption by default. See the `encryption` variable.
#tfsec:ignore:aws-s3-enable-versioning Versioning configuration is separate. Note that this module enables versioning to be enabled by default. See the `versioning_configuration` variable.
#tfsec:ignore:aws-s3-specify-public-access-block This module used a `private` canned ACL by default, which includes a public access block.
#tfsec:ignore:aws-s3-no-public-buckets This module is set to create `private` buckets by default, but allows for creating public buckets if desired.
#tfsec:ignore:aws-s3-ignore-public-acls This module is set to create `private` buckets by default, but allows for creating public buckets if desired.
#tfsec:ignore:aws-s3-block-public-policy This module is set to create `private` buckets by default, but allows for creating public buckets if desired.
#tfsec:ignore:aws-s3-block-public-acls This module is set to create `private` buckets by default, but allows for creating public buckets if desired.
resource "aws_s3_bucket" "generic" {
  #checkov:skip=CKV_AWS_18: "Ensure that S3 buckets are encrypted with KMS by default" - Since this is a re-usable module, this needs to be able to be overridden. Uses AWS KMS encryption by default.
  #checkov:skip=CKV_AWS_19: "Ensure all data stored in the S3 bucket is securely encrypted at rest" - Since this is a re-usable module, this needs to be able to be overridden. Uses AWS KMS encryption by default.
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled" - Since this is a re-usable module, this needs to be able to be overridden. Versioning is enabled by default.
  #checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default" - Since this is a re-usable module, this needs to be able to be overridden.
  #checkov:skip=CKV2_AWS_6: "Ensure that S3 bucket has a Public Access block" - Since this is a re-usable module, this needs to be able to be overridden. Has one by default.

  bucket              = local.bucket_name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_configuration != null ? true : false
  tags                = merge({ "Name" = local.bucket_name }, local.tags)

}
