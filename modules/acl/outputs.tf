output "acl" {
  value       = { for key, value in aws_s3_bucket_acl.canned_acl : key => value }
  description = "A map of properties for the bucket's canned ACL configuration."
}
