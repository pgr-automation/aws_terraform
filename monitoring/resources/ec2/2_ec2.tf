resource "aws_instance" "demo-monitoring" {
    ami = var.ami
    instance_type = var.instance_type
  
}