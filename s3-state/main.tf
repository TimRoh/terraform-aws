provider "aws" {
  region = "eu-central-1"
  profile = "visolon-blog"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "visolon-blog-tfstate"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "visolon-blog-terraform-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}