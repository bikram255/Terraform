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

#vpc
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Git-VPC"
  }
}

#Public Subnet-1
resource "aws_subnet" "public-sub-1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "ap-south-1a"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Public Subnet-1"
  }
}

#Public Subnet-2
resource "aws_subnet" "public-sub-2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "ap-south-1b"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Public Subnet-2"
  }
}

#Internet-Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

/*
#Internet Gateway Attachment
resource "aws_internet_gateway_attachment" "igw-attachement" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.main.id
}
*/

#Route Table
resource "aws_route_table" "rtable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Main Route Table"
  }
}

#Route Table Association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-sub-1.id
  route_table_id = aws_route_table.rtable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-sub-2.id
  route_table_id = aws_route_table.rtable.id
}

#Security Group
resource "aws_security_group" "sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-1"
  }
}

#ec2 GIT-HUB Server Instance
resource "aws_instance" "Git-Hub-Server" {
  ami                     = "ami-0b08bfc6ff7069aff"
  instance_type           = "t2.small"
  subnet_id               = aws_subnet.public-sub-1.id
  vpc_security_group_ids  = [aws_security_group.sg.id]

  tags = {
    Name = "Git-Hub-Server"
  }
}

#ec2 GIT Client Instance
resource "aws_instance" "Git-Client" {
  ami                     = "ami-0b08bfc6ff7069aff"
  instance_type           = "t2.small"
  subnet_id               = aws_subnet.public-sub-2.id
  vpc_security_group_ids  = [aws_security_group.sg.id]

  tags = {
    Name = "Git-Client"
  }
}

#ec2 GIT Client-2 Instance
resource "aws_instance" "Git-Client-2" {
  ami                     = "ami-0b08bfc6ff7069aff"
  instance_type           = "t2.small"
  subnet_id               = aws_subnet.public-sub-2.id
  vpc_security_group_ids  = [aws_security_group.sg.id]

  tags = {
    Name = "Git-Client-2"
  }
}

#Publci IP to Ec2 Instance
resource "aws_eip" "git-server" {
  instance = aws_instance.Git-Hub-Server.id
  vpc      = true
}

#Publci IP to Ec2 Instance
resource "aws_eip" "git-client" {
  instance = aws_instance.Git-Client.id
  vpc      = true
}

#Publci IP to Ec2 Instance-2
resource "aws_eip" "git-client-2" {
  instance = aws_instance.Git-Client-2.id
  vpc      = true
}