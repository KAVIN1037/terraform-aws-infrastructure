AWS Infrastructure Automation Using Terraform & GitHub Actions

Project Overview

This project automates AWS infrastructure provisioning using Terraform and GitHub Actions. It demonstrates Infrastructure as Code (IaC), remote state management, and CI/CD automation with manual approval before applying infrastructure changes.

Technologies Used

AWS
Terraform
GitHub Actions
Git and GitHub
Amazon EC2
Amazon VPC
Amazon S3
AWS IAM

AWS Infrastructure

The Terraform configuration manages the following resources:

Amazon VPC and public subnets
Internet Gateway and routing
EC2 web server
Security Group
Elastic IP
S3 bucket
IAM role and permissions
S3 remote Terraform state with encryption and state locking

Terraform Modules

The project includes reusable Terraform modules for:

Networking
Compute

CI/CD Workflow

The GitHub Actions workflow automates these stages:

Checkout source code
Terraform format check
Terraform initialization
Terraform validation
Terraform plan
Upload the plan as an artifact
Manual approval
Terraform apply
Display Terraform outputs
Validate the deployed infrastructure

Application

The application runs on an EC2 instance and serves a web page using Nginx.

Application URL: http://3.211.166.99

Remote State

Terraform state is stored in an Amazon S3 bucket with encryption and versioning. The backend is configured to use native S3 lockfile-based state locking.

Sensitive state files and AWS credentials must not be committed to the repository.

Deployment

The infrastructure is managed through Terraform and deployed using GitHub Actions. Review the workflow and Terraform configuration before applying infrastructure changes.

Validation

The deployment was validated through a successful GitHub Actions workflow run and AWS console checks. The application URL should be tested again before final submission.

Author

KAVIN1037
