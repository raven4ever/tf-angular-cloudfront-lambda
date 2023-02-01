# Create CloudFront OAC
resource "aws_cloudfront_origin_access_control" "storage_bucket_oac" {
  name                              = format("%s-oac", var.s3_bucket_name)
  description                       = format("OAC for %s bucket.", var.s3_bucket_name)
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Create CloudFront distribution
resource "aws_cloudfront_distribution" "storage_bucket_distribution" {
  enabled             = true
  default_root_object = "index.html"
  tags                = var.tags

  origin {
    origin_id                = format("%s-origin-id", var.s3_bucket_name)
    domain_name              = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.storage_bucket_oac.id
  }

  default_cache_behavior {
    target_origin_id       = format("%s-origin-id", var.s3_bucket_name)
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
