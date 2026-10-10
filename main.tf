module "networking" {
  source = "./modules/networking"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
}

module "compute" {
  source = "./modules/compute"

  environment           = var.environment
  vpc_id                = module.networking.vpc_id
  subnet_id             = module.networking.public_subnet_1_id
  instance_type         = var.instance_type
  ami_id                = var.ami_id
  iam_instance_profile  = aws_iam_instance_profile.ec2_profile.name
  web_security_group_id = module.networking.security_group_id
}

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = "kavin-terraform-${random_id.bucket_suffix.hex}"

  tags = {
    Name        = "terraform-project-bucket"
    Environment = var.environment
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
resource "aws_s3_bucket_versioning" "terraform_bucket" {
  bucket = aws_s3_bucket.terraform_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_bucket" {
  bucket = aws_s3_bucket.terraform_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_bucket" {
  bucket = aws_s3_bucket.terraform_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name        = "${var.environment}-ec2-role"
    Environment = var.environment
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "${var.environment}-ec2-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]
      Resource = "*"
    }]
  })
}