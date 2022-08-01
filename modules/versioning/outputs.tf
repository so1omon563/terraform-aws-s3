output "versioning" {
  value       = { for key, value in aws_s3_bucket_versioning.versioning : key => value }
  description = "A map of properties for the created versioning configuration."
}
