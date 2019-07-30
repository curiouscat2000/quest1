resource "aws_cloudwatch_log_group" "app2" {
  name = "/ecs/${var.service_name}"
}