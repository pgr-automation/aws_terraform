
resource "aws_alb_target_group" "demo-tg" {
  name             = "Demotg"
  port             = 80
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = aws_vpc.my-testvpc.id
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
}

resource "aws_alb_target_group_attachment" "demotg-attach_1a" {
  #for_each = [aws_instance.webserver1a, aws_instance.webserver1b.id]
  
  target_group_arn = aws_alb_target_group.demo-tg.arn
  target_id = aws_instance.webserver1a.id
  port = 80
  
}
resource "aws_alb_target_group_attachment" "demotg-attach_1b" {
  #for_each = [aws_instance.webserver1a, aws_instance.webserver1b.id]
  
  target_group_arn = aws_alb_target_group.demo-tg.arn
  target_id = aws_instance.webserver1b.id
  port = 80
  
}

resource "aws_alb" "demo-alb" {
  name = "demo-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.demo-alb-sg.id ]
  subnets = [aws_subnet.mypublic-subnet_1.id, aws_subnet.mypublic-subnet_2.id]
  tags = {
    Name = "web_demo_alb"
  }
  
}

resource "aws_alb_listener" "demo-alb-listener" {
  load_balancer_arn = aws_alb.demo-alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.demo-tg.arn
  }
  
}