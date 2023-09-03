provider "aws" {
  # Configuration options
}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10.0"
    }
  }

  required_version = ">= 1.3"
}