terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket         = "83s-remote-state-env"
    key            = "expense-dev-vpc"
    region         = "us-east-1"
    #  dynamodb_table = "83s-remote-state-devlop"
       use_lockfile = true
  }


}

provider "aws" {
  region = "us-east-1"
}
