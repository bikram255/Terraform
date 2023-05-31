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
}

variable "instancetag" {
  type = list 
  default = ["dev-dept", "prod-dept", "test-dept", "deploy-dept", "run-dept"]
}

variable "instancetype" {
  type = list 
  default = ["t2.micro", "t2.large", "t2.small", "t2.nano", "t2.medium"]
}
#ec2 Instance Section
resource "aws_instance" "app_server" {
  ami           = "ami-0b08bfc6ff7069aff"
  instance_type = var.instancetype[count.index]
  count         = 5

  tags = {
    Name = var.instancetag[count.index]
  }
}