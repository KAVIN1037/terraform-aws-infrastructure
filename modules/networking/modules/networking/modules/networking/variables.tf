variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "Public subnet 1 CIDR"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "Public subnet 2 CIDR"
  type        = string
}
