output "instance-public-ip" {
  value = "${ aws_instance.Airtel-Server.public_ip }"
  description = "Public IP of Instance"
  sensitive = false
}