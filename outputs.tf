output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.terraform_vpc.id
}
output "public_subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}
output "public_subnet_1b_id" {
  value = aws_subnet.public_subnet_1b.id
}
output "private_subnet_1a_id" {
  value = aws_subnet.private_subnet_1a.id
}
output "private_subnet_1b_id" {
  value = aws_subnet.private_subnet_1b.id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.tf_igw.id
}
