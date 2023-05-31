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
#
resource "aws_ami_from_instance" "from-instance" {
  name               = "ami-from-instance"
  source_instance_id = "i-058caa0413ac9773d"
}