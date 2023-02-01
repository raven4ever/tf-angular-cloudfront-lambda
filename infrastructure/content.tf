# Upload demo content
resource "aws_s3_object" "storage_bucket_demo_content" {
  for_each = fileset(path.module, format("%s/*", var.frontend_artefacts_location))

  bucket       = aws_s3_bucket.storage_bucket.id
  key          = basename(each.value)
  content_type = lookup(tomap(local.mime_types), element(split(".", each.value), length(split(".", each.value)) - 1))
  source       = each.value
  etag         = filemd5(each.value)
}
