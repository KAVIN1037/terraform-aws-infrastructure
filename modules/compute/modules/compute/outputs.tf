output "instance_id" {
  description = "EC2 Instance ID"
   value      = aws_instance.web.id
}

output "elastic_ip" {
  description = "Elastic IP"
  value       = aws_eip.web.public_ip
}

output "security_group_id" {
  description = "Compute Security Group ID"
  value       = aws_security_group.compute.id
}
output "s3_bucket_name" {
  description = "Project S3 Bucket Name"
   value     = aws_s3_bucket.project.bucket
}
