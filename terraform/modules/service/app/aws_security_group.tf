resource "aws_security_group" "appLB" {
  name        = "${var.aws_resource_base_name}_appLB"
  description = "Allow load balancer inbound traffic"
  vpc_id      = "${var.vpc_id}"

   tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_appLB"
    )
  )}"
}
resource "aws_security_group_rule" "lb_allow_https_in" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.appLB.id}"
}
resource "aws_security_group_rule" "lb_allow_http_in" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.appLB.id}"
}
resource "aws_security_group_rule" "lb_allow_outgoing" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = -1
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.appLB.id}"
}



resource "aws_security_group" "ContainerServiceapp" {
  name        = "${var.aws_resource_base_name}_ContainerServiceapp"
  description = "Allow inbound traffic to service containers"
  vpc_id      = "${var.vpc_id}"
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}_ContainerServiceapp"
    )
  )}"
}
resource "aws_security_group_rule" "allow_all_self" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = -1
  self = true
  security_group_id = "${aws_security_group.ContainerServiceapp.id}"
}
resource "aws_security_group_rule" "allow_all_from_lb" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  source_security_group_id = "${aws_security_group.appLB.id}"
  security_group_id = "${aws_security_group.ContainerServiceapp.id}"
}
resource "aws_security_group_rule" "allow_all_from_devops" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks = ["${var.developer_ip}"]
  security_group_id = "${aws_security_group.ContainerServiceapp.id}"
}

resource "aws_security_group_rule" "allow_service_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks = ["${var.developer_ip}"]
  security_group_id = "${aws_security_group.ContainerServiceapp.id}"
}

resource "aws_security_group_rule" "allow_service_outgoing" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ContainerServiceapp.id}"
}

