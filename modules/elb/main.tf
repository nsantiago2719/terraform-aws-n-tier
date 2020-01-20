data "aws_availability_zones" "available" {
}

resource "aws_lb" "elb" {
  name               = var.name
  load_balancer_type = "application"

  subnets         = var.subnets
  security_groups = var.security-groups
}

resource "aws_lb_target_group" "target-group" {
  name     = "${var.name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id

  health_check {
    interval = 10
    timeout  = 5
    port     = 80
    path     = "/"
  }
}

resource "aws_lb_listener" "http-listner" {
  load_balancer_arn = aws_lb.elb.arn

  port     = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group_attachment" "target-attachment" {
  count            = length(var.instance-ids)
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = element(var.instance-ids, count.index)
  port             = 80
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.elb.arn

  port            = 443
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.certificate-arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

