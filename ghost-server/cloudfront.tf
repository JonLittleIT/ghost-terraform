
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_eip.ghost-eip.public_ip}"
    origin_id   = "${var.name}-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "/"

  aliases = ["${var.domain_name}", "www.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.name}-origin"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  tags {
    Environment = "${var.name}-production"
  }

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.ssl_acm_arn}"
  }
}
