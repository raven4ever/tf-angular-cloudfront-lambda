resource "aws_apigatewayv2_api" "storage_apigw" {
  name          = format("%s-api", var.s3_bucket_name)
  protocol_type = "HTTP"
}
