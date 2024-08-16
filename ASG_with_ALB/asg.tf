resource "aws_autoscaling_group" "demo-asg" {
  name = "demo-asg"
  desired_capacity = "2"
  min_size = "1"
  max_size = "3"
  vpc_zone_identifier = [ aws_subnet.asg-pubsubnet-demo-1a.id, aws_subnet.asg-pubsubnet-demo-1b.id,aws_subnet.asg-pubsubnet-demo-1c.id ]
  
  
  
  launch_template {
    id = aws_launch_template.asg-lt-demo.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.asg-tg-demo.arn ]
  tag {
    key = "demo-asg"
    value = "webserver-"
    propagate_at_launch = true
  }
  lifecycle {
    
    create_before_destroy = true
  }
  
  
}