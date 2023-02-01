output "website_url" {
  description = "URL to access the CloudFront distribution"
  value       = local.website_url
}

output "lambda_backend_url" {
  description = "URL to access the Lambda backend"
  value       = local.backend_url
}
