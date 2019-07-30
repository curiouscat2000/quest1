resource "aws_route_table_association" "publicA" {
  subnet_id      = "${aws_subnet.publicA.id}"
  route_table_id = "${aws_route_table.public.id}"
}
resource "aws_route_table_association" "publicB" {
  subnet_id      = "${aws_subnet.publicB.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "privateA" {
  subnet_id      = "${aws_subnet.privateA.id}"
  route_table_id = "${aws_route_table.private.id}"
}
resource "aws_route_table_association" "privateB" {
  subnet_id      = "${aws_subnet.privateB.id}"
  route_table_id = "${aws_route_table.private.id}"
}
