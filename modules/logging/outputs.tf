output "logging" {
  value       = { for key, value in aws_s3_bucket_logging.logging : key => value }
  description = "A map of properties for the created logging configuration."
}
