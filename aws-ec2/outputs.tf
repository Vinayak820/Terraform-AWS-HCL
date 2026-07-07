output "aws_instance_public_ip" {
  value       = aws_instance.myserver.public_ip
  description = "The public IP address of the EC2 instance"
}
