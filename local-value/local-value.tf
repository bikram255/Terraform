#Provider Section
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
  region     = "ap-south-1"
}

locals {
  uk = {
    Name = "UK-Project"
    Owner = "Bikram Samantaray"
  }
}

locals {
  usa = {
    Name = "USA Project"
    Owner = "Bikram Samantaray"
  }
}

#ec2 Instance Section
resource "aws_instance" "app_server" {
  ami                    = "ami-0b08bfc6ff7069aff"
  instance_type          = "t2.micro"
  tags = local.usa
}

#VPC
resource "aws_vpc" "davppl_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = local.uk
}

