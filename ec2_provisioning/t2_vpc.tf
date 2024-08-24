resource "aws_vpc" "demo-vpc" {
  cidr_block = "11.0.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "demo-subnets" {
    for_each = {
      "us-east-1a" = "11.0.1.0/24"
      "us-east-1b" = "11.0.2.0/24" 
    }
    vpc_id = aws_vpc.demo-vpc.id
    cidr_block = each.value
    availability_zone = each.key
    map_public_ip_on_launch = true

    tags = {
      Name = "subnet-${each.key}"
    }
  
}
resource "aws_internet_gateway" "demo-igw" {
    vpc_id = aws_vpc.demo-vpc.id
    tags = {
      Name = "demo-igw"
    }
  
}

resource "aws_route_table" "demo-rt" {
    vpc_id = aws_vpc.demo-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo-igw.id
    }
    tags = {
      Name = "demo-rt"
    }
  
}

resource "aws_route_table_association" "demo-rt-assocication" {
    for_each = aws_subnet.demo-subnets
    subnet_id = each.value.id
    route_table_id = aws_route_table.demo-rt.id
  
}