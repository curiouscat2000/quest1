resource "aws_eip" "nat" {
  vpc      = true
    tags = "${merge(
    local.common_tags,
    map(
       "Name", "${var.aws_resource_base_name}-natEIP"
    )
  )}"
}