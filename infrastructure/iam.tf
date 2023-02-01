resource "aws_iam_role" "lambda_role" {
  name                 = var.lambda_role_name
  assume_role_policy   = data.aws_iam_policy_document.lambda_role_assume_policy.json
  permissions_boundary = var.lambda_role_boundary == "" ? "" : data.aws_iam_policy.lambda_role_boundary_policy[0].arn
  tags                 = var.tags
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name_prefix = format("%s-policy", var.lambda_role_name)
  role        = aws_iam_role.lambda_role.id
  policy      = data.aws_iam_policy_document.lambda_role_permissions_policy.json
}
