resource "aws_instance" "demo-webserv" {
    count = 1
    ami = var.ami_value   
    instance_type = var.instance_type_value
    key_name = data.aws_key_pair.demo-ssh-key.key_name
    user_data = ""
    subnet_id = element(local.for_each, count.index % length(local.for_each))
    vpc_security_group_ids = [ aws_security_group.demo-sg.id ]

    tags = {
      Name = "demo-webserv-10${count.index +1}"
      Environment = "Dev-env"
    }
  
}