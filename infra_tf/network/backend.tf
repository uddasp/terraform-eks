terraform {
  backend "s3" {
    bucket         = "uddasp-tfstate"
    key            = "network.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}
