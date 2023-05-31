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


#ec2 Instance Section
resource "aws_instance" "app_server" {
  ami                    = "ami-0b08bfc6ff7069aff"
  instance_type          = "t2.micro"

  tags = {
    Name = "App-Server"
  }
}

/*
output "instance-info-ami" {
    value = aws_instance.app_server.ami
}

output "instance-info-instance-type" {
    value = aws_instance.app_server.instance_type
}

output "instance-info-host-id" {
    value = aws_instance.app_server.id
}

*/

