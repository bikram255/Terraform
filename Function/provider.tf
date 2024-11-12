terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "test-bucket-9778"
    key    = "function.tfstate"
    region = "ap-south-1"
  }
}


