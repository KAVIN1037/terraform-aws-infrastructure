output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.web.id
}

output "elastic_ip" {
  description = "Elastic IP"
  value       = aws_eip.web.public_ip
}

output "security_group_id" {
  description = "Compute Security Group ID"
  value       = aws_security_group.compute.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = var.vpc_id
}

output "application_url" {
  description = "Application URL"
  value       = "http://${aws_eip.web.public_ip}"
}
