output "cors" {
  value       = { for key, value in aws_s3_bucket_cors_configuration.cors : key => value }
  description = "A map of properties for the bucket's CORS configuration."
}
