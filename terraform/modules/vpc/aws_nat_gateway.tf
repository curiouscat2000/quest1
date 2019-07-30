resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.publicA.id}"
  depends_on = ["aws_internet_gateway.default"]

    tags = "${merge(
    local.common_tags,
    map(
       "Name", "${var.aws_resource_base_name}-natGW"
    )
  )}"
}