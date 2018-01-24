# Application load balancer that distributes load between the instances
resource "aws_alb" "ecs_alb" {
  name            = "ecs-alb"
  internal        = false
  security_groups = ["${aws_security_group.alb_securitygroup.id}"]

  subnets = ["${aws_subnet.umg_public_a.id}", "${aws_subnet.umg_public_b.id}"]
}

# ALB listener that checks for connection requests from clients using the port/protocol specified
# These requests are then forwarded to one or more target groups, based on the rules defined
resource "aws_alb_listener" "instance_listener" {
  load_balancer_arn = "${aws_alb.ecs_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alg_tg.arn}"
    type             = "forward"
  }

  depends_on = ["aws_alb_target_group.alg_tg"]
}

# Default ALB target group that defines the default port/protocol the instances will listen on
resource "aws_alb_target_group" "alg_tg" {
  name     = "alg-tg"
  protocol = "HTTP"
  port     = "8080"
  vpc_id   = "${aws_vpc.umg.id}"

  health_check {
    path = "/"
  }
}
