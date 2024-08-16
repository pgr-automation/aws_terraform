provider "aws" {
  region = "us-east-1"

}

resource "aws_instance" "webserver1a" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mypublic-subnet_1.id
  key_name      = data.aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [
    aws_security_group.mytestsg.id
    
  ]
  availability_zone = "us-east-1a"
  user_data = file("${path.module}/user-data.sh")
  #count     = 1
  tags = {
    Name = "webserver10"
  }

}

resource "aws_instance" "webserver1b" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mypublic-subnet_2.id
  key_name      = data.aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [
    aws_security_group.mytestsg.id
    
  ]
  associate_public_ip_address = true
  availability_zone = "us-east-1b"
  user_data = file("${path.module}/user-data.sh")
  #count     = 1
  tags = {
    Name = "webserver11"
  }

}