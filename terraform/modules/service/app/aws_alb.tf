resource "aws_alb" "ecs-load-balancer" {
    security_groups     = ["${aws_security_group.appLB.id}"]
    subnets             = "${var.vpc_public_subnets_ids}"
    lifecycle {
        create_before_destroy = true
    }
    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}externalLB"
    )
  )}"
}