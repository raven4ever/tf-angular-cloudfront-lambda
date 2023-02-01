locals {
  website_url = format("https://%s", aws_cloudfront_distribution.website_bucket_distribution.domain_name)
  backend_url = format("%s/%s", aws_apigatewayv2_stage.apigw_stage.invoke_url, var.api_stage_path)

  mime_types = {
    "css"   = "text/css"
    "html"  = "text/html"
    "ico"   = "image/vnd.microsoft.icon"
    "js"    = "application/javascript"
    "json"  = "application/json"
    "map"   = "application/json"
    "png"   = "image/png"
    "svg"   = "image/svg+xml"
    "txt"   = "text/plain"
    "woff"  = "font/woff"
    "woff2" = "font/woff2"
    "ttf"   = "font/ttf"
    "eot"   = "font/eot"
  }
}
