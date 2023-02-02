data "archive_file" "frontend_zip" {
  type        = "zip"
  source_dir  = "../frontend"
  output_path = "frontend.zip"
}

resource "null_resource" "build_frontend" {
  provisioner "local-exec" {
    working_dir = "../frontend"
    command     = format("export NG_APP_API_URL=%s; npm i; ng build", local.backend_url)
  }

  triggers = {
    frontend_hash = data.archive_file.frontend_zip.output_sha
  }

  depends_on = [
    aws_apigatewayv2_stage.apigw_stage
  ]
}
