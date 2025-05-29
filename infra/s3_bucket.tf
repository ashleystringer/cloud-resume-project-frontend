locals {
  s3_origin_id = "myS3Origin"
  website_file = {
    "index.html" = "text/html"
    "styles.css" = "text/css"
    "script.js" = "application/javascript"
  }
}

resource "aws_s3_bucket" "cloud-resume-project-s3" {
	bucket = "cloud-resume-project-s3"
}

resource "aws_s3_bucket_public_access_block" "crp_public_access_block" {
  bucket = aws_s3_bucket.cloud-resume-project-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "crp_website_config" {
  bucket = aws_s3_bucket.cloud-resume-project-s3.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "website_files" {
  for_each = local.website_file
  bucket     = aws_s3_bucket.cloud-resume-project-s3.id
  key = each.key
  source = "../src/${each.key}"
  ##etag = filemd5("${path.module}/src/${each.key}")
  content_type = each.value
}


