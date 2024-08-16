resource "aws_vpc" "cf-vpc" {
  cidr_block = "14.0.0.0/16"
  tags = {
    Name = "cf-vpc"
  }
  
}

resource "aws_subnet" "cf-subnets" {
  for_each = {
    "us-east-1a" = "14.0.1.0/24"
    "us-east-1b" = "14.0.2.0/24"
  }
  vpc_id = aws_vpc.cf-vpc.id
  cidr_block = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
  tags = {
    Name = "cf-subnets-${each.key}"
  }
  
}

resource "aws_internet_gateway" "cf-igw" {
  vpc_id = aws_vpc.cf-vpc.id
  tags = {
    Name = "cf-igw"
  }
}

resource "aws_route_table" "cf-RT" {
  vpc_id = aws_vpc.cf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cf-igw.id
  }
  
}
resource "aws_route_table_association" "cf-RT-association-1a" {
  for_each = aws_subnet.cf-subnets
  subnet_id = each.value.id
  route_table_id = aws_route_table.cf-RT.id
  
}
