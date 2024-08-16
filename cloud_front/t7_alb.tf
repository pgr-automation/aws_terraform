resource "aws_lb_target_group" "cf-alb-tg" {
    name = "cf-alb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.cf-vpc.id
    
    health_check {
        port = "80"
        path = "/"
        matcher = "200-399"
        protocol = "HTTP"
        healthy_threshold = 5
        interval = 5
        unhealthy_threshold = 5
        timeout = 3
    }
}
resource "aws_lb_target_group_attachment" "cf-tga" {

    #count = length(aws_instance.cf-intsaces)
    for_each =  { for idx, inst in aws_instance.cf-instances :  idx => inst }
    target_group_arn = aws_lb_target_group.cf-alb-tg.arn
    #target_id = aws_instance.cf-intsaces[count.index].id
    target_id = each.value.id
    port = 80
  
}

resource "aws_lb" "cf-alb" {
    name = "cf-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.cf-alb-sg.id]
    subnets = [for subnet in aws_subnet.cf-subnets: subnet.id ]
    tags = {
      Name = "cf-alb"
    }
  
}

resource "aws_lb_listener" "cf-alb-listner" {
    load_balancer_arn = aws_lb.cf-alb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.cf-alb-tg.arn
    }
  
}