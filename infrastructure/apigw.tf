resource "aws_apigatewayv2_api" "apigw_api" {
  name          = format("%s-apigw", var.lambda_function_name)
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "apigw_stage" {
  api_id      = aws_apigatewayv2_api.apigw_api.id
  name        = var.api_stage_name
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "apigw_integration" {
  api_id = aws_apigatewayv2_api.apigw_api.id

  integration_uri    = aws_lambda_function.backend_lambda.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "apigw_route" {
  api_id = aws_apigatewayv2_api.apigw_api.id

  route_key = format("GET /%s", var.api_stage_path)
  target    = "integrations/${aws_apigatewayv2_integration.apigw_integration.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = format("/aws/api_gw/%s", aws_apigatewayv2_api.apigw_api.name)
  retention_in_days = 30
}

resource "aws_lambda_permission" "apigw_lambda_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backend_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}
