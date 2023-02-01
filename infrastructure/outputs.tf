output "storage_bucket" {
  description = "Storage Bucket regional domain name"
  value       = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
}

output "distribution_url" {
  description = "URL to access the CloudFront distribution"
  value       = format("http://%s", aws_cloudfront_distribution.storage_bucket_distribution.domain_name)
}
