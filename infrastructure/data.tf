data "aws_iam_policy_document" "website_bucket_policy_document" {
  statement {
    sid       = "AllowOACAccessToBucketObjects"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.website_bucket.arn}/*"]
    actions   = ["s3:GetObject"]
    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.website_bucket_oai.iam_arn
      ]
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
    actions = ["ec2:CreateNetworkInterface", "ec2:DescribeNetworkInterfaces", "ec2:DeleteNetworkInterface"]
    resources = [
      "*"
    ]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
