resource "aws_lb" "external_alb" {
  name               = "${var.environment}-${var.project}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.external_alb_sg.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  idle_timeout                     = var.idle_timeout

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-alb"
    }
  )
}

resource "aws_lb_target_group" "external_tg" {
  name     = "${var.environment}-${var.project}-tg"
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    port                = "traffic-port"
    protocol            = "HTTP"
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-tg"
    }
  )

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }
}

resource "aws_lb" "internal_alb" {
  name               = "${var.environment}-${var.project}-in-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_alb_sg.id]
  subnets            = aws_subnet.frontend[*].id

  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  idle_timeout                     = var.idle_timeout

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-internal-alb"
    }
  )
}

resource "aws_lb_target_group" "internal_tg" {
  name     = "${var.environment}-${var.project}-in-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled             = true
    port                = "traffic-port"
    protocol            = "HTTP"
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-internal-tg"
    }
  )
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_tg.arn
  }

  tags = var.tags
}

resource "aws_lb_listener" "https_listener" {
  count             = var.certificate_arn != "" ? 1 : 0
  load_balancer_arn = aws_lb.external_alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS-1-3-2021-06"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external_tg.arn
  }

  tags = var.tags
}

resource "aws_lb_listener_rule" "https_redirect_rule" {
  count        = var.certificate_arn != "" ? 1 : 0
  listener_arn = aws_lb_listener.http_listener.arn

  action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  tags = var.tags
}

resource "aws_lb_listener" "internal_http_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_tg.arn
  }

  tags = var.tags
}