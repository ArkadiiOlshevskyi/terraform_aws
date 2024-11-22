terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75"
    }
  }
}

provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "my_test_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# SUBNET
resource "aws_subnet" "my_test_subnet" {
  vpc_id     = aws_vpc.my_test_vpc.id
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.subnet_name
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_test_vpc.id

  tags = {
    Name = var.internet_gateway
  }
}

# ROUTE TABLE
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }

  tags = {
    Name = var.internet_gateway
  }
}

# ASSOCIATES ROUTE TABLE WITH SUBNET
resource "aws_route_table_association" "public_1_rt_assoc" {
  subnet_id      = aws_subnet.my_test_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# SECURITY GROUP FOR HTTP TRAFFIC
resource "aws_security_group" "dev_sec_group" {
  name   = "HTTP"
  vpc_id = aws_vpc.my_test_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "ec2_example" {
  ami                         = var.ec2_operation_system_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.my_test_subnet.id
  vpc_security_group_ids      = [aws_security_group.dev_sec_group.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex
  amazon-linux-extras install nginx1 -y
  echo "<h1>This is dev server</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = var.ec2_instance_name
  }
}

# Outputs
output "GATEWAY" {
  value = aws_internet_gateway.my_ig.id
}

output "VPC" {
  value = aws_vpc.my_test_vpc.id
}

output "SUBNET" {
  value = aws_subnet.my_test_subnet.id
}
