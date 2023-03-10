# Create CloudFront OAI
resource "aws_cloudfront_origin_access_identity" "website_bucket_oai" {
  comment = aws_s3_bucket.website_bucket.id
}

# Create CloudFront distribution
resource "aws_cloudfront_distribution" "website_bucket_distribution" {
  enabled             = true
  default_root_object = "index.html"
  tags                = var.tags

  origin {
    origin_id   = format("%s-origin-id", var.website_bucket_name)
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website_bucket_oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = format("%s-origin-id", var.website_bucket_name)
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
