resource "aws_lb_target_group" "asg-tg-demo" {
  name = "asg-tg-demo"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.asg-vpc-demo.id
  health_check {
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200-399"
    port                = "80"
    healthy_threshold   = 5
    interval            = 30
    unhealthy_threshold = 5
    timeout             = 5

  }
  tags = {
    Name = "asg-tg-demo"
  }
  
}

