resource "aws_lb" "lb" {
  name               = "${local.project_name}-lb"
  internal           = false
  security_groups    = local.network.security_groups
  subnets            = local.network.subnet_ids
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "lb_target_blue" {
  name        = "${local.project_name}-blue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = local.network.vpc_id
  target_type = "ip"

  health_check {
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    protocol            = "HTTP"
    port                = "traffic-port"
  }
}

resource "aws_lb_target_group" "lb_target_green" {
  name        = "${local.project_name}-green"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = local.network.vpc_id
  target_type = "ip"

  health_check {
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
    protocol            = "HTTP"
    port                = "traffic-port"
  }
}

## Listeners
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  lifecycle {
    ignore_changes = [default_action]
  }

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_blue.arn
    type             = "forward"
  }
}
