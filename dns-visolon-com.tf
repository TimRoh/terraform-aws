module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 1.0"

  zones = {
    "visolon.com" = {
      comment = "visolon.com (production)"
      tags = {
        env = "production"
      }
    }

    "visolon.com" = {
      comment = "visolon .com domain dns zone"
    }
  }
}

