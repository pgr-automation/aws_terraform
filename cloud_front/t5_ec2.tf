locals {
  for_each = [for subnet in aws_subnet.cf-subnets : subnet.id]  # Extracting only the subnet IDs
}

resource "aws_instance" "cf-instances" {
  count = 3
  ami = var.ami_value
  instance_type = var.instance_type_value
  key_name = data.aws_key_pair.cf-ssh-key.key_name
  user_data = file("${path.module}/data.sh")

  # Distribute instances across subnets using the element function
  subnet_id = element(local.for_each, count.index % length(local.for_each))

  vpc_security_group_ids = [aws_security_group.cf-sg.id]

  tags = {
    Name = "webserv10${count.index + 2}"
  }
}