resource "aws_acm_certificate" "visolon_blog" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Environment = "Production"
    ManagedBy = "Terraform"
  }
# cert needs to be in the us_east_1 region for cloudfront!  
  provider = aws.us_east_1

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "visolon_blog" {
  name = var.domain_name
}

resource "aws_route53_record" "visolon_blog_validation" {
  for_each = {
    for dvo in aws_acm_certificate.visolon_blog.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.visolon_blog.zone_id
}

resource "aws_acm_certificate_validation" "visolon_blog" {
  certificate_arn         = aws_acm_certificate.visolon_blog.arn
  validation_record_fqdns = [for record in aws_route53_record.visolon_blog_validation : record.fqdn]
# cert needs to be in the us_east_1 region for cloudfront!  
  provider = aws.us_east_1
}