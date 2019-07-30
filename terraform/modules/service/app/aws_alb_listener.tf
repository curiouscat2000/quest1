resource "aws_alb_listener" "alb-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "80"
    protocol          = "HTTP"
    lifecycle {
        create_before_destroy = true
    }
    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
        type             = "forward"
    }
}


resource "aws_alb_listener" "alb_listener_https" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy		  =	"ELBSecurityPolicy-2016-08"
    certificate_arn		=	"${var.ssl_cert_arn}"
    lifecycle {
        create_before_destroy = true
    }
    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
        type             = "forward"
    }
}
