#VPC
resource "aws_vpc" "vpc_wordpress" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc_wordpress"
  }
}

########################################################################################
#Internet gateway IGW
resource "aws_internet_gateway" "IGW_wordpress" {
  vpc_id = aws_vpc.vpc_wordpress.id

  tags = {
    Name = "IGW_wordpress"
  }

}

########################################################################################
#Public subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.vpc_wordpress.id
  cidr_block = var.public_subnet1_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.vpc_wordpress.id
  cidr_block = var.public_subnet2_cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet2"
  }
}

########################################################################################
#Private subnets
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc_wordpress.id
  cidr_block = var.private_subnet1_cidr
  availability_zone = var.az1

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.vpc_wordpress.id
  cidr_block = var.private_subnet2_cidr
  availability_zone = var.az2

  tags = {
    Name = "private_subnet2"
  }
}

########################################################################################
#NAT Gateways and Elastic IPs
resource "aws_eip" "EIP_NAT_GW1" {
  domain = "vpc"
}

resource "aws_eip" "EIP_NAT_GW2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "NAT_GW1" {
  allocation_id = aws_eip.EIP_NAT_GW1.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "NAT_GW1"
  }

  depends_on = [aws_internet_gateway.IGW_wordpress]
}

resource "aws_nat_gateway" "NAT_GW2" {
  allocation_id = aws_eip.EIP_NAT_GW2.id
  subnet_id     = aws_subnet.public_subnet2.id

  tags = {
    Name = "NAT_GW2"
  }
  depends_on = [aws_internet_gateway.IGW_wordpress]
}

########################################################################################
#Route table - Public Subnets to IGW
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.vpc_wordpress.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.IGW_wordpress.id
  } 
  
  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table_association" "PublicRT_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRT_subnet2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.PublicRT.id
}

########################################################################################
#2x Route tables - Private subnets to each NAT GW
resource "aws_route_table" "PrivateRT1" {
  vpc_id = aws_vpc.vpc_wordpress.id

  route {
    cidr_block = var.internet_cidr
    nat_gateway_id = aws_nat_gateway.NAT_GW1.id
  } 
  
  tags = {
    Name = "PrivateRT1"
  }
}

resource "aws_route_table_association" "PrivateRT1_subnet1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.PrivateRT1.id
}

resource "aws_route_table" "PrivateRT2" {
  vpc_id = aws_vpc.vpc_wordpress.id

  route {
    cidr_block = var.internet_cidr
    nat_gateway_id = aws_nat_gateway.NAT_GW2.id
  } 
  
  tags = {
    Name = "PrivateRT2"
  }
}

resource "aws_route_table_association" "PrivateRT2_subnet2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.PrivateRT2.id
}