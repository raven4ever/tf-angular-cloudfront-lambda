data "aws_iam_policy_document" "storage_bucket_policy_document" {
  statement {
    sid       = "AllowOACAccessToBucketObjects"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.storage_bucket.arn}/*"]
    actions   = ["s3:GetObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.storage_bucket_distribution.arn]
    }
  }
}
