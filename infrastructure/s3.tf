# Create storage bucket
resource "aws_s3_bucket" "storage_bucket" {
  bucket = var.s3_bucket_name
  tags   = var.tags
}

# Make the bucket private
resource "aws_s3_bucket_acl" "storage_bucket_acl" {
  bucket = aws_s3_bucket.storage_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "storage_bucket_public_access" {
  bucket = aws_s3_bucket.storage_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "storage_bucket_encryption" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Attach bucket policy
resource "aws_s3_bucket_policy" "storage_bucket_policy" {
  bucket = aws_s3_bucket.storage_bucket.id
  policy = data.aws_iam_policy_document.storage_bucket_policy_document.json
}
