output "storage_bucket" {
  description = "Storage Bucket regional domain name"
  value       = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
}

output "distribution_url" {
  description = "URL to access the CloudFront distribution"
  value       = local.distribution_https_url
}
