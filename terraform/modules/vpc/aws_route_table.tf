resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.ecstest2.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_route_public"
    )
  )}"
}
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.ecstest2.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.gw.id}"
    }
    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_route_private"
    )
  )}"
}