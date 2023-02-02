data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../backend"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "backend_lambda" {
  filename      = data.archive_file.lambda_zip.source_file
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
}
