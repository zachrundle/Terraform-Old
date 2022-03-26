resource "aws_vpc" "CyberShady-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "CyberShady"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.CyberShady-VPC.id
}

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.CyberShady-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }
}
resource "aws_subnet" "subnet-prod" {
  vpc_id     = aws_vpc.CyberShady-VPC.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name        = "subnet-prod"
    Environment = "Production"
  }
}
resource "aws_subnet" "subnet-dev" {
  vpc_id     = aws_vpc.CyberShady-VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name        = "subnet-dev"
    Environment = "Development"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-dev.id
  route_table_id = aws_route_table.prod-route-table.id
}