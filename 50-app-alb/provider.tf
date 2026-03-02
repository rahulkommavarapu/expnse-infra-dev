terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }  
  # To store the State file in S3 Bucket 
  backend "s3" {
    bucket         = "83s-remote-state-devlop"  # Bucket Name
    key            = "expense-dev-app-alb" # bucket Key
    region         = "us-east-1"               
    dynamodb_table = "83s-remote-state-devlop" # buckect lock purpose
  }


}

provider "aws" {
  region = "us-east-1"
}
