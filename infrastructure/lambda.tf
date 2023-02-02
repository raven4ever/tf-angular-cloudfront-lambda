data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../backend"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "backend_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.9"

  environment {
    variables = {
      NEPTUNE_URL         = aws_neptune_cluster.default.endpoint
      NEPTUNE_PORT        = "8182"
      INITIAL_DATA_LOADED = "False"
    }
  }

  vpc_config {
    subnet_ids         = data.aws_subnets.subnets.ids
    security_group_ids = [aws_security_group.neptune_sg.id]
  }
}
