resource "aws_lb" "asg-alb-demo" {
  name = "asg-alb-demo"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.asg-sg-demo.id ]
  subnets = [ aws_subnet.asg-pubsubnet-demo-1a.id, aws_subnet.asg-pubsubnet-demo-1b.id, aws_subnet.asg-pubsubnet-demo-1c.id]
  
}

resource "aws_lb_listener" "asg-lb-demo" {
  load_balancer_arn = aws_lb.asg-alb-demo.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg-tg-demo.arn
  }
  
}