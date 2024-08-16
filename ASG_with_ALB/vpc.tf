resource "aws_vpc" "asg-vpc-demo" {
  cidr_block = "12.0.0.0/16"
  tags = {
    Name = "asg-vpc-demo"
  }
  
}

resource "aws_subnet" "asg-pubsubnet-demo-1a" {
  vpc_id = aws_vpc.asg-vpc-demo.id
  cidr_block = "12.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "asg-pubsubnet-demo-1a"
  }
  
}

resource "aws_subnet" "asg-pubsubnet-demo-1b" {
  vpc_id = aws_vpc.asg-vpc-demo.id
  cidr_block = "12.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "asg-pubsubnet-demo-1b"
  }
  
}

resource "aws_subnet" "asg-pubsubnet-demo-1c" {
  vpc_id = aws_vpc.asg-vpc-demo.id
  cidr_block = "12.0.3.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "asg-pubsubnet-demo-1c"
  }
  
}

resource "aws_internet_gateway" "asg-igw-demo" {
  vpc_id = aws_vpc.asg-vpc-demo.id
  tags = {
    Name = "asg-igw-demo"
  }

}

resource "aws_route_table" "asg-pubRT" {
  vpc_id = aws_vpc.asg-vpc-demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.asg-igw-demo.id
  }
  tags = {
    Name = "asg-pubRT"
  }
  
}

resource "aws_route_table_association" "asg-pubRT-associatoin-1a" {
  subnet_id = aws_subnet.asg-pubsubnet-demo-1a.id
  route_table_id = aws_route_table.asg-pubRT.id

}


resource "aws_route_table_association" "asg-pubRT-associatoin-1b" {
  subnet_id = aws_subnet.asg-pubsubnet-demo-1b.id
  route_table_id = aws_route_table.asg-pubRT.id

}
resource "aws_route_table_association" "asg-pubRT-associatoin-1c" {
  subnet_id = aws_subnet.asg-pubsubnet-demo-1c.id
  route_table_id = aws_route_table.asg-pubRT.id

}