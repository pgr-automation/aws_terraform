resource "aws_security_group" "asg-sg-demo" {
  name = "asg-sg-demo"
  description = "asg-sg-demo"
  vpc_id = aws_vpc.asg-vpc-demo.id
  tags = {
    Name = "asg-sg-demo"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
  }
  
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = "0"
    to_port = "0"
    protocol = "-1"
  }
}