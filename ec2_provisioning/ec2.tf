provider "aws" {
  region = "us-east-1"
  
}

resource "aws_instance" "webserver" {
  count = 2
  tags = {
    Name = "webserver10${count.index + 4}"
  }

  ami = var.ami_value
  instance_type = var.instance_type_value
  subnet_id = var.subnet_id_value
  key_name = var.key_name_value
  associate_public_ip_address = true
  vpc_security_group_ids = [
    data.aws_security_group.Linux-sg.id,
    aws_security_group.demo-efs-sg.id
  ]
  user_data = <<-EOF
              #!/bin/bash
              yum install -y amazon-efs-utils
              mkdir /mnt/efs
              mount -t efs -o tls ${aws_efs_file_system.demo-efs.id}:/ /mnt/efs
              EOF
  availability_zone = element(["us-east-1a","us-east-1b"],count.index) 
}