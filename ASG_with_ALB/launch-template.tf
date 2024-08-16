resource "aws_launch_template" "asg-lt-demo" {
  name_prefix = "webserver-10"
  image_id = "ami-0583d8c7a9c35822c"
  key_name = data.aws_key_pair.asg-demo-ssh-key.key_name
  instance_type = "t2.micro"
  user_data = filebase64("${path.module}/data.sh")


  network_interfaces {
    associate_public_ip_address = true
    security_groups = [ aws_security_group.asg-sg-demo.id ]
  }
  

  
}