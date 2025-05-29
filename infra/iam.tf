resource "aws_iam_policy" "crp_cloudfront_access_policy" {
  name        = "crp_cloudfront_access_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetBucketAcl",
          "s3:PutBucketAcl"
        ]
        Resource = "arn:aws:s3:::mylogs"
      },
    ]
  })
}

resource "aws_iam_role" "crp_cloudfront_access_role" {
  name = "crp_cloudfront_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy_attachment" "crp_cloudfront_policy_attachment" {
  name       = "crp-cloudfront-policy-attachment"
  roles      = [aws_iam_role.crp_cloudfront_access_role.name]
  policy_arn = aws_iam_policy.crp_cloudfront_access_policy.arn
}