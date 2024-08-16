
resource "aws_vpc" "my-testvpc" {
  cidr_block = "11.0.0.0/16"

  tags = {
    Name = "my-test-vpc"
  }

}

resource "aws_subnet" "mypublic-subnet_1" {
  vpc_id                  = aws_vpc.my-testvpc.id
  cidr_block              = "11.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "mypublic-subnet"
  }

}

resource "aws_subnet" "mypublic-subnet_2" {
  vpc_id                  = aws_vpc.my-testvpc.id
  map_public_ip_on_launch = false
  cidr_block              = "11.0.2.0/24"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "myprivate-subnet"
  }

}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.my-testvpc.id
  tags = {
    Name = "myigw"
  }

}

resource "aws_route_table" "mypubRT_1" {
  vpc_id = aws_vpc.my-testvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "mypubRT_1"
  }
}
resource "aws_route_table" "mypubRT_2" {
  vpc_id = aws_vpc.my-testvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "mypubeRT_2"
  }
}

resource "aws_route_table_association" "mypubRT-association" {
  subnet_id      = aws_subnet.mypublic-subnet_1.id
  route_table_id = aws_route_table.mypubRT_1.id

}
resource "aws_route_table_association" "myprivateRT-association" {
  subnet_id      = aws_subnet.mypublic-subnet_2.id
  route_table_id = aws_route_table.mypubRT_2.id

}

resource "aws_security_group" "mytestsg" {
  name   = "mytestsg"
  vpc_id = aws_vpc.my-testvpc.id
  tags = {
    Name = "mytestsg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "myingress_rule" {
  security_group_id = aws_security_group.mytestsg.id
  #cidr_ipv4         = aws_vpc.my-testvpc.cidr_block
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "myingress_rule_web" {
  security_group_id = aws_security_group.mytestsg.id
  #cidr_ipv4         = aws_vpc.my-testvpc.cidr_block
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "myegress_rule" {
  security_group_id = aws_security_group.mytestsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "demo-alb-sg" {
  name   = "demo-alb-sg"
  vpc_id = aws_vpc.my-testvpc.id
  tags = {
    Name = "demo-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "myingress-alb_rule_web" {
  security_group_id = aws_security_group.demo-alb-sg.id
  #cidr_ipv4         = aws_vpc.my-testvpc.cidr_block
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
resource "aws_vpc_security_group_egress_rule" "myegress-alb_rule" {
  security_group_id = aws_security_group.demo-alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
