# Upload demo content
resource "aws_s3_object" "storage_bucket_demo_content" {
  for_each = fileset("../frontend", "dist/frontend/*")

  bucket = aws_s3_bucket.storage_bucket.id
  key    = each.value
  source = "../frontend/dist/frontend/${each.value}"
  etag   = filemd5("../frontend/dist/frontend/${each.value}")
}