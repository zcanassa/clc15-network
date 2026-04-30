resource "aws_vpc" "terraform_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "tf-vpc"
    CC    = "123456"
    Owner = "DevOps"
  }
}

resource "aws_subnet" "subnet_public_1a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "public-tf-subnet-1a" }
}

resource "aws_subnet" "subnet_private_1a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "private-tf-subnet-1a" }
}

resource "aws_subnet" "subnet_public_1b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "public-tf-subnet-1b" }
}

resource "aws_subnet" "subnet_private_1b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.200.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "private-tf-subnet-1b" }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = { Name = "tf-vpc-igw" }
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = { Name = "tf-public-rt" }
}

resource "aws_route_table_association" "public_1a_association" {
  subnet_id      = aws_subnet.subnet_public_1a.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "public_1b_association" {
  subnet_id      = aws_subnet.subnet_public_1b.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_eip" "tf_ip_nat_1a" {
  domain = "vpc"
}

resource "aws_eip" "tf_ip_nat_1b" {
  domain = "vpc"
}

resource "aws_nat_gateway" "tf_natgateway_1a" {
  allocation_id = aws_eip.tf_ip_nat_1a.id
  subnet_id     = aws_subnet.subnet_public_1a.id
  tags = { Name = "tf-natgw-1a" }
  depends_on = [aws_internet_gateway.tf_igw]
}

resource "aws_nat_gateway" "tf_natgateway_1b" {
  allocation_id = aws_eip.tf_ip_nat_1b.id
  subnet_id     = aws_subnet.subnet_public_1b.id
  tags = { Name = "tf-natgw-1b" }
  depends_on = [aws_internet_gateway.tf_igw]
}

resource "aws_route_table" "tf_private_rt_1a" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_natgateway_1a.id
  }
  tags = { Name = "tf-private-rt-1a" }
}

resource "aws_route_table" "tf_private_rt_1b" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_natgateway_1b.id
  }
  tags = { Name = "tf-private-rt-1b" }
}

resource "aws_route_table_association" "private_1a_association" {
  subnet_id      = aws_subnet.subnet_private_1a.id
  route_table_id = aws_route_table.tf_private_rt_1a.id
}

resource "aws_route_table_association" "private_1b_association" {
  subnet_id      = aws_subnet.subnet_private_1b.id
  route_table_id = aws_route_table.tf_private_rt_1b.id
}

resource "aws_flow_log" "example" {
  log_destination      = "arn:aws:s3:::clc15-zcanassa-terraform"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.terraform_vpc.id
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = { Name = "my-iac-sg" }
}
