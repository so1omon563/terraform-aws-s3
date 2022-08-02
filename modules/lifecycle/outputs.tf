output "lifecycle" {
  value       = { for key, value in aws_s3_bucket_lifecycle_configuration.lifecycle : key => value }
  description = "A map of properties for the bucket's lifecycle configuration."
}
