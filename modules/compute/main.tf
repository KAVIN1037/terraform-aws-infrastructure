

resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  iam_instance_profile        = var.iam_instance_profile
  vpc_security_group_ids      = [var.web_security_group_id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Terraform AWS Infrastructure</h1><p>Application is running successfully.</p>" > /var/www/html/index.html
              EOF

  tags = {
    Name        = "${var.environment}-web-server"
    Environment = var.environment
  }
}

resource "aws_eip" "web" {
  domain = "vpc"

  tags = {
    Name = "${var.environment}-elastic-ip"
  }
}

resource "aws_eip_association" "web" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.web.id
}
