terraform {
  backend "s3" {
    bucket         = "visolon-blog-tfstate"
    key            = "remote-state/terraform.tfstate"
    dynamodb_table = "visolon-blog-terraform-state"
    region         = "eu-central-1"
    encrypt        = "true"
    profile        = "visolon-blog"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.2.0"
    }
  }
}

provider aws {
  profile = "visolon-blog"
  region  = "eu-central-1"
}
