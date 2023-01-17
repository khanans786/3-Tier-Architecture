terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
  }
}

provider "aws" {
  access_key = "AKIA2YLSLGQFI7QRM443"
  secret_key = "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"
  region     = "us-east-1"
}  