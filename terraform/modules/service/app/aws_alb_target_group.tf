resource "aws_alb_target_group" "ecs-target-group" {
    port                = "${var.container_port}"
    protocol            = "HTTP"
    vpc_id              = "${var.vpc_id}"
    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "6"
    }
    lifecycle {
      create_before_destroy = true
    }
    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_ExternalLBTargetGroup"
    ),
    "${var.tags}"
  )}"
}