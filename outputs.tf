output "bucket" {
  value = merge(
    { name = aws_s3_bucket.generic.bucket },
    { for key, value in aws_s3_bucket.generic : key => value }
  )
  description = "A map of properties for the created bucket."
}

output "accelerate_module" {
  value       = module.accelerate
  description = "A map of properties for the created accelerate configuration."
}

output "encryption_module" {
  value       = module.encryption
  description = "A map of properties for the bucket's encryption configuration."
}

output "logging_module" {
  value       = module.logging
  description = "A map of properties for the created logging configuration."
}

output "oai_module" {
  value       = module.oai
  description = "A map of properties for the created origin access identity."
}

output "versioning_module" {
  value       = module.versioning
  description = "A map of properties for the created versioning configuration."
}
