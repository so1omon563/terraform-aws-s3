output "accelerate" {
  value       = { for key, value in aws_s3_bucket_accelerate_configuration.accelerate : key => value }
  description = "A map of properties for the created accelerate configuration."
}
