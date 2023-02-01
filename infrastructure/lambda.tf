resource "aws_lambda_function" "backend_lambda" {
  filename      = "${path.module}/lambda.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
}
