output "request_payer" {
  value       = { for key, value in aws_s3_bucket_request_payment_configuration.payer : key => value }
  description = "A map of properties for the request payer configuration."
}
