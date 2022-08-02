output "policy" {
  value       = { for key, value in aws_s3_bucket_policy.policy : key => value }
  description = "A map of properties for the created bucket policy."
}
