
/*
  Public Subnet az1
*/
resource "aws_subnet" "publicA" {
    vpc_id = "${aws_vpc.ecstest2.id}"

    cidr_block = "10.0.0.0/24"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"

    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_subnetPublicA"
    )
  )}"
}
/*
  Public Subnet az2
*/
resource "aws_subnet" "publicB" {
    vpc_id = "${aws_vpc.ecstest2.id}"

    cidr_block = "10.0.1.0/24"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"

    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_subnetPublicB"
    )
  )}"
}
/*
  Private Subnet az1
*/
resource "aws_subnet" "privateA" {
    vpc_id = "${aws_vpc.ecstest2.id}"

    cidr_block = "10.0.20.0/24"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"

    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_subnetPrivateA"
    )
  )}"
}
/*
  Private Subnet az2
*/
resource "aws_subnet" "privateB" {
    vpc_id = "${aws_vpc.ecstest2.id}"

    cidr_block = "10.0.21.0/24"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"

    tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_subnetPrivateB"
    )
  )}"
}