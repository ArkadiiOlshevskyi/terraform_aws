##### NETWORK #####
output "GATEWAY_2" {
  description = "Dev aws gateway"
  value       = aws_internet_gateway.my_ig.id
}

output "VPC_2" {
  description = "Dev aws vpc"
  value       = aws_vpc.my_test_vpc.id
}

output "SUBNET_2" {
  description = "Dev aws subnet"
  value       = aws_subnet.my_test_subnet.id
}



##### EC2 #####
output "ec2_instance_id" {
  description = "ec2 id"
  value = aws_instance.ec2_example.id
}

output "ec2_instance_pub_ip" {
  description = "ec2 public IP"
  value = aws_instance.ec2_example.public_ip
}

output "ec2_instance_pub_dns" {
  description = "ec2 public DNS"
  value = aws_instance.ec2_example.public_dns
}

output "ec2_instance_avl_zone" {
  description = "ec2 avaliability zone"
  value = aws_instance.ec2_example.availability_zone
}