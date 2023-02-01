output "website_url" {
  description = "URL to access the CloudFront distribution"
  value       = format("http://%s", aws_cloudfront_distribution.website_bucket_distribution.domain_name)
}

output "lambda_backend_url" {
  description = "URL to access the Lambda backend"
  value       = format("%s/%s", aws_apigatewayv2_stage.lambda.invoke_url, var.api_stage_path)
}
