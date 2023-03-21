output "object_ownership" {
  value       = { for key, value in aws_s3_bucket_ownership_controls.ownership : key => value }
  description = "A map of properties for the bucket's Object Ownership configuration."
}
