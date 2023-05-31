output "instance-info-ami" {
    value = aws_instance.app_server.ami
}

output "instance-info-instance-type" {
    value = aws_instance.app_server.instance_type
}

output "instance-info-host-id" {
    value = aws_instance.app_server.id
    sensitive = true
}