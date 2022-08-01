output "encryption" {
  value       = { for key, value in aws_s3_bucket_server_side_encryption_configuration.encryption : key => value }
  description = "A map of properties for the bucket's encryption configuration."
}
