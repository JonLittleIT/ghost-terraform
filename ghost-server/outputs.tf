# output "elb_dns" { value = "${aws_elb.ghost.dns_name}" }
output "cloudfront-dns" { value = "${aws_cloudfront_distribution.ghost-blog.domain_name}" }
