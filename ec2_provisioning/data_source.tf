data "aws_security_group" "Linux-sg" {
  id = var.linux-sg_value
}

data "aws_vpc" "demo-vpc" {
  id = var.vpc_id_value
}