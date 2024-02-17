terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_vpc" "Airtel-VPC" {
  cidr_block = var.vpc_cidr
  tags = {
    name = "Airtel--VPC"
  }
}

resource "aws_subnet" "Airtel-Subnet" {
  vpc_id            = aws_vpc.Airtel-VPC.id
  availability_zone = "ap-south-1a"
  cidr_block        = var.airtel_subnet
}

resource "aws_internet_gateway" "Airtel-IGW" {
  vpc_id = aws_vpc.Airtel-VPC.id
  tags = {
    name = "airtel-igw"
  }
}

resource "aws_route_table" "Airtel-RT" {
  vpc_id = aws_vpc.Airtel-VPC.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Airtel-IGW.id
  }
}

resource "aws_route_table_association" "Airtel-RT-Association" {
  route_table_id = aws_route_table.Airtel-RT.id
  subnet_id      = aws_subnet.Airtel-Subnet.id
}

resource "aws_security_group" "Airtel-SG" {
  vpc_id = aws_vpc.Airtel-VPC.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "Airtel--SG"
  }
}

resource "aws_key_pair" "Airtel-keypair" {
  public_key = var.keypair.public_key
  key_name   = var.keypair.key_name
  tags = {
    name = "SSh Keyair to SSH"
  }
}

resource "aws_instance" "Airtel-Server" {
  vpc_security_group_ids = [ aws_security_group.Airtel-SG.id ]
  subnet_id                   = aws_subnet.Airtel-Subnet.id
  instance_type               = var.ec2instanceconfig.instance_type
  ami                         = var.ec2instanceconfig.ami
  associate_public_ip_address = var.ec2instanceconfig.associate_public_ip
  key_name                    = var.keypair.key_name

  tags = {
    name = "Airtel-Server-Created"
  }
}
