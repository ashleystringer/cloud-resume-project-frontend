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

//CREATE A BUCKET POLICY
resource "aws_s3_bucket_policy" "s3_bucket_policy_cloudfront" {
  bucket = aws_s3_bucket.cloud-resume-project-s3.id
  policy = data.aws_iam_policy_document.allow_access_for_cloudfront.json
}

output "s3_bucket_name" {
  value = aws_s3_bucket.cloud-resume-project-s3.id
}

data "aws_iam_policy_document" "allow_access_for_cloudfront" {
  statement {
    sid = "AllowCloudFrontServicePrincipal"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    
    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.cloud-resume-project-s3.arn,
      "${aws_s3_bucket.cloud-resume-project-s3.arn}/*",
    ]

    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [
        aws_cloudfront_distribution.cloudfront_distribution.arn
      ]
    }

  }
}

/*
##### ORIGINAL BUCKET POLICY #####
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal", //FIGURE OUT WHAT THIS IS
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::ashls-crp-s3-v1/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::851725342515:distribution/EPSDK7Z5FM07V"
                }
            }
        }
    ]
} 
##########

*/

resource "aws_s3_object" "website_files" {
  for_each = local.website_file
  bucket     = aws_s3_bucket.cloud-resume-project-s3.id
  key = each.key
  source = "../src/${each.key}"
  content_type = each.value
}


