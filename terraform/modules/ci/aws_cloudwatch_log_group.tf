resource "aws_cloudwatch_log_group" "code_build_logs" {
  name = "${var.aws_resource_base_name}/codebuild/logs/${var.service_name}"
  tags = "${merge(
    local.common_tags,
    "${var.tags}"
  )}"
}
