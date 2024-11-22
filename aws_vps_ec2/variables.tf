# REGION
variable "region" {
  description = "AWS region"
  type        = string
}

# NETWORK
variable "vpc_name" {
  description = "My VPC"
  type = string
  default = "MyVPC"
}

variable "vpc_cidr" {
  description = "My VPC cidr"
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "My Subnet"
  type = string
  default = "MySubnet"
}

variable "subnet_cidr" {
  description = "My Subnet cidr"
  type = string
  default = "10.0.1.0/24"
}

variable "internet_gateway" {
  description = "My Interner Gateway"
  type = string
  default = "MyInternetGateway"
}


# EC2 settings
variable "ec2_instance_name" {
  description = "EC2_instance_2"
  type = string
  default = "EC2FreeTier"
}

  # cpu and os
variable "ec2_instance_type" {
  description = "AWS EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "ec2_operation_system_ami" {
  description = "ami for operation system like Ubuntu"
  type = string
  default = "ami-0866a3c8686eaeeba"
}


