resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.ecstest2.id}"
    tags = "${merge(
      local.common_tags,
      map(
        "Name", "${var.aws_resource_base_name}-IG"
      )
    )}"
}