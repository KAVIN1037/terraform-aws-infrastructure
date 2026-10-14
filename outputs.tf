
output "instance_id" {
  description = "EC2 Instance ID"
  value       = module.compute.instance_id
}

output "elastic_ip" {
  description = "Elastic IP"
  value       = module.compute.elastic_ip
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
  value       = "http://${module.compute.elastic_ip}"
}

output "s3_bucket_name" {
  description = "Project S3 Bucket Name"
  value       = aws_s3_bucket.project.bucket
}
