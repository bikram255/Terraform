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

variable "elbname" {
  type = string
}
variable "azname" {
    type = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Create a new load balancer
resource "aws_elb" "bar" {
  name               = "var.elbname"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

 
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

   health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elb"
  }
}