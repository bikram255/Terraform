locals {
  dept   = "Test"
  owner  = "Master Card PVT.LTD"
  TeamDL = "Bikram Samantaray"
}

#-------------------------------------Test VPC
resource "aws_vpc" "Test-VPC" {
  cidr_block           = var.vpc-cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name   = "${var.vpc_tag}"
    dept   = local.dept
    owner  = local.owner
    TeamDL = local.TeamDL
  }
}



#---------------------------------------------------Public Route Table
resource "aws_route_table" "Test-Public-RT" {
  vpc_id = aws_vpc.Test-VPC.id

  route {
    cidr_block = var.vpc-cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Test-IGW.id
  }


  tags = {
    Name   = "Public_Rout_Table"
    dept   = local.dept
    owner  = local.owner
    TeamDL = local.TeamDL
  }
}

#---------------------------------------------------Private Route Table
resource "aws_route_table" "Test-Private-RT" {
  vpc_id = aws_vpc.Test-VPC.id

  route {
    cidr_block = var.vpc-cidr_block
    gateway_id = "local"
  }

  tags = {
    Name   = "Test-Private-RT"
    dept   = local.dept
    owner  = local.owner
    TeamDL = local.TeamDL
  }
}

# #----------------------------------------------------Subnet Association to Public Route Table
# resource "aws_route_table_association" "Public-Subnet-1-Association-RT" {
#   subnet_id      = aws_subnet.Public-Subnet-1.id
#   route_table_id = aws_route_table.Test-Public-RT.id
# }

# resource "aws_route_table_association" "Public-Subnet-2-Association-RT" {
#   subnet_id      = aws_subnet.Public-Subnet-2.id
#   route_table_id = aws_route_table.Test-Public-RT.id
# }

# resource "aws_route_table_association" "Public-Subnet-3-Association-RT" {
#   subnet_id      = aws_subnet.Public-Subnet-3.id
#   route_table_id = aws_route_table.Test-Public-RT.id
# }

# #----------------------------------------------------Subnet Association to Private Route Table
# resource "aws_route_table_association" "Private-Subnet-1-Association-RT" {
#   subnet_id      = aws_subnet.Private-Subnet-1.id
#   route_table_id = aws_route_table.Test-Private-RT.id
# }

# resource "aws_route_table_association" "Private-Subnet-2-Association-RT" {
#   subnet_id      = aws_subnet.Private-Subnet-2.id
#   route_table_id = aws_route_table.Test-Private-RT.id
# }

# #-------------------------------------------------------------------------Security Group
# resource "aws_security_group" "Test-SG" {
#   name        = "Test-Security-Group"
#   description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = aws_vpc.Test-VPC.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name   = "Test-SG"
#     dept   = local.dept
#     owner  = local.owner
#     TeamDL = local.TeamDL
#   }
# }

#---------------------------------------------Internet Gateway
resource "aws_internet_gateway" "Test-IGW" {
  vpc_id = aws_vpc.Test-VPC.id

  tags = {
    Name        = "${var.vpc_tag}-IGW"
    dept        = local.dept
    owner       = local.owner
    TeamDL      = local.TeamDL
    Environment = "${var.environment}"
  }

  depends_on = [aws_vpc.Test-VPC]
}

# #-----------------------------------------------EC2 Instance
# resource "aws_instance" "Test-Web" {
#   subnet_id = aws_subnet.Public-Subnet-1.id
#   # availability_zone           = var.ec2-az
#   instance_type          = var.instance_type
#   ami                    = var.ami #Amazon-Linux
#   vpc_security_group_ids = [aws_security_group.Test-SG.id]
#   #key_name                    = aws_key_pair.deployer.id
#   associate_public_ip_address = true
#   root_block_device {
#     volume_size = 20 # Set the desired volume size in GB
#   }
#   tags = {
#     Name   = "Test-Server"
#     dept   = local.dept
#     owner  = local.owner
#     TeamDL = local.TeamDL
#   }
# }

# # resource "aws_key_pair" "deployer" {
# #   key_name   = "terraform.pub"
# #   public_key = file("${path.module}/terraform.pub")
# # }

