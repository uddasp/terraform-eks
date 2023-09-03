provider "aws" {
  region = "us-east-1" # Use your desired AWS region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "uddasp-tfstate"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform_locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "uddasp-tfstate"
    key            = "backend.tfstate"
    region         = "us-east-1" # Use your desired AWS region
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}
