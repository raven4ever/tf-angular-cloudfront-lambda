resource "null_resource" "build_frontend" {
  provisioner "local-exec" {
    working_dir = "../frontend"
    command     = format("export NG_APP_API_URL=%s; npm i; ng build", local.backend_url)
  }

  depends_on = [
    aws_apigatewayv2_stage.apigw_stage
  ]
}
