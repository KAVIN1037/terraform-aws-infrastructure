output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = module.compute.instance_id
}

output "elastic_ip" {
  description = "Elastic IP"
  value       = module.compute.elastic_ip
}

output "application_url" {
  description = "Application URL"
  value       = "http://${module.compute.elastic_ip}"
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.terraform_bucket.bucket
}