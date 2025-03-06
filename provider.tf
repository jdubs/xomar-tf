terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Adjust as needed
    }
  }
}

provider "aws" {
  region  = "us-east-1" # Change based on your preference
  profile = "xomar"
}
