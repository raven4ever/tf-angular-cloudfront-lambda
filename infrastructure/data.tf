data "aws_iam_policy_document" "website_bucket_policy_document" {
  statement {
    sid       = "AllowOACAccessToBucketObjects"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
    actions   = ["s3:GetObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.website_bucket_distribution.arn]
    }
  }
}

data "aws_iam_policy" "lambda_role_boundary_policy" {
  count = var.lambda_role_boundary == "" ? 0 : 1
  name  = var.lambda_role_boundary
}

data "aws_iam_policy_document" "lambda_role_assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_role_permissions_policy" {
  statement {
    effect  = "Allow"
    actions = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../backend"
  output_path = "${path.module}/lambda.zip"
}
