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

variable "instancetype" {
  type = map(any)
  default = {
    "dev"  = "t2.small"
    "test" = "t2.medium"
    "prod" = "t2.micro"
  }
}

variable "input" {}

#Dev Instance
resource "aws_instance" "dev" {
  instance_type = var.instancetype["dev"]
  ami           = "ami-02eb7a4783e7e9317"
  count         = var.input == "dev" ? 4 : 0
}

#Test Instance
resource "aws_instance" "test" {
  instance_type = var.instancetype["test"]
  ami           = "ami-02eb7a4783e7e9317"
  count         = var.input == "test" ? 5 : 0
}

#Prod Instance
resource "aws_instance" "prod" {
  instance_type = var.instancetype["prod"]
  ami           = "ami-02eb7a4783e7e9317"
  count         = var.input == "prod" ? 1 : 0
}