#vpc
resource "aws_vpc" "ireland" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ireland.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}


#public_subnet_1
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.ireland.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true #for public subnet only

  tags = {
    Name = "${var.project_name}-public-subnet-1"
  }
}


#public_subnet_2
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.ireland.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true #for public subnet only

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}


#private_subnet_1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.ireland.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.project_name}-private-subnet-1"
  }
}

#private_subnet_2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.ireland.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.project_name}-private-subnet-2"
  }
}


#elastic ip
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}


#before creating nat ,make sure we have igw
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "${var.project_name}-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}


#public route table -- attach to igw
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ireland.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

#Associate Public Route Table - public subnet 1
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

#Associate Public Route Table - public subnet 2
resource "aws_route_table_association" "public_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}


#Private Route Table -- attach to nat (igw - public_route_tables -nat- private_route_table}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.ireland.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}


#Associate Private Route Table - private Subnet 1
resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

#Associate Private Route Table - private Subnet 2
resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}


































