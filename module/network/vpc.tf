# =====================
# VPC
# =====================
resource "aws_vpc" "eks_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "igw-terraform-eks"
    environment = "development"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "igw_vpc_eks" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name        = "igw-terraform-eks"
    environment = "development"
  }
}


# Subnets

# Public Subnets
resource "aws_subnet" "eks_public_a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-subnet-a-terraform-eks"
    "kubernetes.io / role / elb" = 1
    environment                  = "development"
  }
}

resource "aws_subnet" "eks_public_b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-subnet-b-terraform-eks"
    "kubernetes.io / role / elb" = 1
    environment                  = "development"
  }
}

# Private Subnets
resource "aws_subnet" "eks_private_1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "private-subnet-a-terraform-eks"
    environment = "delevopment"
  }
}

resource "aws_subnet" "eks_private_1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name        = "private-subnet-b-terraform-eks"
    environment = "development"
  }
}


# Route Tables

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_vpc_eks.id
  }

  tags = {
    Name        = "public-rt-terraform-eks"
    environment = "development"
  }
}

resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name        = "private-rt-a-terraform-eks"
    environment = "development"
  }
}

resource "aws_route_table" "private_b" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name        = "private-rt-b-terraform-eks"
    environment = "development"
  }
}


# Route Table Association

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.eks_public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.eks_public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.eks_private_1a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.eks_private_1b.id
  route_table_id = aws_route_table.private_b.id
}


# NAT Gateways

resource "aws_eip" "nat_a" {
  domain = "vpc"
  tags   = { Name = "nat-eip-a-terraform-eks" }
}

resource "aws_eip" "nat_b" {
  domain = "vpc"
  tags   = { Name = "nat-eip-b-terraform-eks" }
}

resource "aws_nat_gateway" "nat_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.eks_public_a.id

  tags = {
    Name        = "nat-gateway-a-terraform-eks"
    environment = "development"
  }

  depends_on = [aws_internet_gateway.igw_vpc_eks]
}

resource "aws_nat_gateway" "nat_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.eks_public_b.id

  tags = {
    Name        = "nat-gateway-b-terraform-eks"
    environment = "development"
  }

  depends_on = [aws_internet_gateway.igw_vpc_eks]
}



# Routet Private NAT

resource "aws_route" "private_a_route" {
  route_table_id         = aws_route_table.private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_a.id
}

resource "aws_route" "private_b_route" {
  route_table_id         = aws_route_table.private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_b.id
}


# Security Group

resource "aws_security_group" "security_group" {
  name        = "security-group-terraform"
  description = "ec2 terraform security group"
  vpc_id      = aws_vpc.eks_vpc.id

  # ingress

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.28.48.0/20"]
  }

  # Egress

  egress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "security-group-terraform"
    environment = "development"
  }
}