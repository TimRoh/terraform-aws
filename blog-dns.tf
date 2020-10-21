resource "aws_route53_record" "visolon_blog_a_record" {
   zone_id = aws_route53_zone.visolon_blog.zone_id
   name = var.domain_name
   type = "A"
   alias {
    name = aws_cloudfront_distribution.visolon_blog.domain_name
    zone_id = aws_cloudfront_distribution.visolon_blog.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "visolon_blog_c_name" {
  zone_id = aws_route53_zone.visolon_blog.zone_id
  name = "www"
  type = "CNAME"
  ttl = "300"
  records = [var.domain_name]
}