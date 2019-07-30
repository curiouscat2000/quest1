resource "aws_ecs_cluster" "app2_cluster" {
    name = "${var.aws_resource_base_name}_${var.ecs_cluster}"
    tags = local.common_tags
}