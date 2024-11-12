# #-----------------------------------------------------Subnet
# resource "aws_subnet" "Public-Subnet" { #---------------------------Public Subnet
#   count             = 3
#   vpc_id            = aws_vpc.Test-VPC.id
#   cidr_block        = "${element(var.public-cidr_block, count.index+1)}"
#   availability_zone = "${element(var.az, count.index+1)}"

#   tags = {
#     Name   = "${var.public_subnet_tag}-${count.index}"
#     dept   = local.dept
#     owner  = local.owner
#     TeamDL = local.TeamDL
#   }
# }

# #-----------------------------------------------------Subnet
# resource "aws_subnet" "Private-Subnet" { #---------------------------Private Subnet
#   count             = 3
#   vpc_id            = aws_vpc.Test-VPC.id
#   cidr_block        = "${element(var.private-cidr_block, count.index)}"
#   availability_zone = "${element(var.az, count.index)}"

#   tags = {
#     Name   = "${var.private_subnet_tag}-${count.index}"
#     dept   = local.dept
#     owner  = local.owner
#     TeamDL = local.TeamDL
#   }
# }






#-----------------------------------------------------Subnet
resource "aws_subnet" "Public-Subnet" { #---------------------------Public Subnet
  count             = 3
  vpc_id            = aws_vpc.Test-VPC.id
  cidr_block        = element(var.public-cidr_block, count.index + 1)
  availability_zone = element(var.az, count.index + 1)

  tags = {
    Name   = "${var.public_subnet_tag}-${count.index}"
    dept   = local.dept
    owner  = local.owner
    TeamDL = local.TeamDL
  }
}

#-----------------------------------------------------Subnet
resource "aws_subnet" "Private-Subnet" { #---------------------------Private Subnet
  count             = 3
  vpc_id            = aws_vpc.Test-VPC.id
  cidr_block        = element(var.private-cidr_block, count.index)
  availability_zone = element(var.az, count.index)

  tags = {
    Name   = "${var.private_subnet_tag}-${count.index}"
    dept   = local.dept
    owner  = local.owner
    TeamDL = local.TeamDL
  }
}














































































































































































