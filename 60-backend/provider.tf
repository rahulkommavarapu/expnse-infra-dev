terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket         = "83s-remote-state-devlop" 
    key            = "expense-dev-backend"
    region         = "us-east-1"
    # dynamodb_table = "83s-remote-state-devlop"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}