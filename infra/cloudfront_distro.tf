// ***** NOT COMPLETE YET *****

resource "aws_cloudfront_origin_access_control" "cloudfront_oac" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name              = aws_s3_bucket.cloud-resume-project-s3.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_oac.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    ##cache_policy_id = "CachingOptimized"

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

    # Cache behavior with precedence 0
  ordered_cache_behavior {
    cache_policy_id = aws_cloudfront_cache_policy.testing_cache.id
    path_pattern     = "/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    compress               = true
    viewer_protocol_policy = "allow-all"
  }

    # Cache behavior with precedence 1
  ordered_cache_behavior {
    cache_policy_id = aws_cloudfront_cache_policy.testing_cache.id
    path_pattern     = "/*.css"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}

/*
CREATE CACHE POLICY OR POLICIES
- Precedence: 0, Path pattern: /*, Origin or origin groups: myS3Origin, Viewer protocol policy: HTTP and HTTPS, Cache policy name: testing_cache
- Precedence: 0, Path pattern: /*css, Origin or origin groups: myS3Origin, Viewer protocol policy: HTTP and HTTPS, Cache policy name: testing_cache
- Precedence: 0, Path pattern: Default (*), Origin or origin groups: myS3Origin, Viewer protocol policy: HTTPS only, Cache policy name: Managed-CachingOptimized

Cache policy: testing_cache
TTL - Minimum: 30 (seconds), Maximum (seconds): 600, Defualt: 480 (seconds)
Cache key settings - Headers: Origin, Access-Control-Request-Method, Access-Control-Request-Headers, Cookies: None, Query strings: None
Compression supports - Gzip, Brotli
*/

resource "aws_cloudfront_cache_policy" "testing_cache" {
  name        = "example-policy"
  comment     = "test comment"
  default_ttl = 480
  max_ttl     = 600
  min_ttl     = 30

  ##enable_accept_encoding_brotli = true
  ##enable_accept_encoding_gzip   = true
  
  parameters_in_cache_key_and_forwarded_to_origin {
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"]
      }
    }
    cookies_config {
      cookie_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

output "cloudfront_distro_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}