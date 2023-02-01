resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/lambda.zip"
  function_name = "SuperDuperUberLambda"
  role          = aws_iam_role.put_cw_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.9"
}
