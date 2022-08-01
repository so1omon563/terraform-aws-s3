output "oai" {
  value       = { for key, value in aws_cloudfront_origin_access_identity.oai : key => value }
  description = "A map of properties for the created origin access identity."
}
