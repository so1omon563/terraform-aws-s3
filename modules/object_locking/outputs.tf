output "object_locking" {
  value       = { for key, value in aws_s3_bucket_object_lock_configuration.object_locking : key => value }
  description = "A map of properties for the object locking configuration."
}
