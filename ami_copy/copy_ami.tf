terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

#Provider (You can add you Access Key & Secret Key here)
provider "aws" {
  region     = "us-east-1"
}

#Copy AMI
resource "aws_ami_copy" "AMI-COPY-Example" {
  name              = "terraform-example-copy"
  description       = "A copy of ami-xxxxxxxx"
  source_ami_id     = "ami-024bd4f0a8c7f4cec"
  source_ami_region = "ap-south-1"

  tags = {
    Name = "HelloWorld"
  }
}
