#ALB, listener and TG
resource "aws_lb" "ALB" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  ip_address_type = "ipv4"
  security_groups    = [var.alb_sg_id]
  subnets = [ 
    var.public_subnet1_id, 
    var.public_subnet2_id
  ]
}

resource "aws_lb_listener" "HTTP_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.EC2_instances_TG.arn
    type             = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_302"
    }
  }
}

resource "aws_lb_listener" "HTTPS_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = var.cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.EC2_instances_TG.arn
  }
}

resource "aws_lb_target_group" "EC2_instances_TG" {
  name     = "TG-for-instances"
  port     = "80"
  protocol = "HTTP"
  ip_address_type = "ipv4"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200-399"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
    port                = "80"
  }
}

resource "aws_lb_target_group_attachment" "Attach_to_instance1" {
  target_group_arn = aws_lb_target_group.EC2_instances_TG.arn
  target_id        = var.ec2_1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Attach_to_instance2" {
  target_group_arn = aws_lb_target_group.EC2_instances_TG.arn
  target_id        = var.ec2_2_id
  port             = 80
}

