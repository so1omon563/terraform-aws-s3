output "public_access_block" {
  value       = { for key, value in aws_s3_bucket_public_access_block.generic : key => value }
  description = "A map of properties for the bucket's Public Access Block configuration."
}
