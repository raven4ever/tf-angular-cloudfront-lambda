# Upload demo content
resource "aws_s3_object" "storage_bucket_demo_content" {
  for_each = fileset("../frontend", "dist/frontend/*")

  bucket = aws_s3_bucket.storage_bucket.id
  key    = each.value
  source = "../frontend/${each.value.source_path}"
  etag   = filemd5("../frontend/${each.value.source_path}")
}
