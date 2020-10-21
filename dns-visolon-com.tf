resource "aws_route53_zone" "visolon_blog" {
  name = var.domain_name
  comment = "Managed by Terraform"
}

