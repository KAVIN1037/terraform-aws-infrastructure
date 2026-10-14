
resource "aws_security_group" "compute" {
  name        = "${var.environment}-compute-sg"
  description = "Security group for EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-compute-sg"
  }
}

module "compute" {
  source = "./modules/compute"

  environment           = var.environment
  vpc_id                = var.vpc_id
  subnet_id             = var.subnet_id
  instance_type         = var.instance_type
  ami_id                = var.ami_id
  web_security_group_id = aws_security_group.compute.id
  iam_instance_profile  = data.aws_iam_instance_profile.ec2_profile.name
}

resource "aws_s3_bucket" "project" {
  bucket = "${var.environment}-${data.aws_caller_identity.current.account_id}-project-bucket"

  tags = {
    Name        = "${var.environment}-project-bucket"
    Environment = var.environment
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}-ec2-instance-profile"
}
