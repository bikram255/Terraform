variable "vpc_cidr" {
  type        = string
  description = "Airtel VPC CIDR Variable"
  default     = "10.1.0.0/16"
}

variable "airtel_subnet" {
  type        = string
  description = "Subnet for Airtel VPC"
  default     = "10.1.1.0/24"
}

variable "keypair" {
  type = object({
    public_key = string
    key_name   = string
  })
  description = "SSh Keypair"
  default = {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDgV2D9B6yBIgh2mMScCPq7IjUj+w9Eaffog3Tg90Nx+Tv1Xr3J9+I7rwCAca/iVF8f0sH0D3YKMyF8BjyilTA+SNLWbmBlfnGfIN5/bFrBVDpOq81WwdLNvccwlOlkY75X2qaEOCC0O445C+WMZPHJ/trRgr+GSvLFgKyQ1hA46vDNb34Bqh9fp1+lyKfRR/GdtdZ8hPzSQNixqNh2jqZ5jbcckCA0SYoUOgdq3B06ADgtK3mRSuHA5IsT7g32rLePu3wKKM/cr7M/hYpYFSjXEajwWU3dITsleXiWHb4pS6fSDBYTOOOsR38a2jjJdJT7OrDsdcL/n6AA3LBHv7fywwLFGxBHMIhaZ39N9a2GTvGwpAkUbJxbPM/LxlaFeTYxHdj0XYBVDOt6FLFS2PV8lR0X4msUoXEF7gF6JLKf3z214IqgqeNF1Z9M6YXVTNC5r21EOXiuy6MQJlX1X5kZFI+a04u4bGxOl62cgEa/TUmWsJI/575NaBECaQe17U= Administrator@DAV-NEW1"
    key_name   = "terraformkp"
  }
}

variable "ec2instanceconfig" {
  type = object({
    instance_type       = string
    ami                 = string
    associate_public_ip = bool
  })
  description = "ec2 Configuration"
  default = {
    instance_type       = "t2.micro"
    ami                 = "ami-03f4878755434977f"
    associate_public_ip = true
  }
}