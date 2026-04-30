resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "tf-vpc", Owner = "DevOps" }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "public-tf-subnet-1a", Owner = "DevOps" }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "private-tf-subnet-1a", Owner = "DevOps" }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "public-tf-subnet-1b", Owner = "DevOps" }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.terraform_vpc.id
  cidr_block        = "10.0.200.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "private-tf-subnet-1b", Owner = "DevOps" }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = { Name = "tf-igw", Owner = "DevOps" }
}

resource "aws_eip" "nat_eip_1a" {
  domain = "vpc"
  tags = { Name = "ip-nat-1a", Owner = "DevOps" }
}

resource "aws_eip" "nat_eip_1b" {
  domain = "vpc"
  tags = { Name = "ip-nat-1b", Owner = "DevOps" }
}

resource "aws_nat_gateway" "nat_gw_1a" {
  subnet_id     = aws_subnet.public_subnet_1a.id
  allocation_id = aws_eip.nat_eip_1a.id
  tags = { Name = "tf-nat-1a", Owner = "DevOps" }
  depends_on = [aws_internet_gateway.tf_igw]
}

resource "aws_nat_gateway" "nat_gw_1b" {
  subnet_id     = aws_subnet.public_subnet_1b.id
  allocation_id = aws_eip.nat_eip_1b.id
  tags = { Name = "tf-nat-1b", Owner = "DevOps" }
  depends_on = [aws_internet_gateway.tf_igw]
}

resource "aws_route_table" "tf_public_rt" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = { Name = "tf-public-rt", Owner = "DevOps" }
}

resource "aws_route_table" "tf_private_rt_1a" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1a.id
  }
  tags = { Name = "tf-private-rt-1a", Owner = "DevOps" }
}

resource "aws_route_table" "tf_private_rt_1b" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1b.id
  }
  tags = { Name = "tf-private-rt-1b", Owner = "DevOps" }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.tf_public_rt.id
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.tf_private_rt_1a.id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.tf_private_rt_1b.id
}

resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = "arn:aws:s3:::${var.bucket_name}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.terraform_vpc.id
  tags = { Name = "tf-vpc-flow-log", Owner = "DevOps" }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = { Name = "my-iac-sg", Owner = "DevOps" }
}
 
 
