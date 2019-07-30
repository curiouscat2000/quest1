resource "aws_iam_instance_profile" "ecs-instance-profile" {
    name = "${var.aws_resource_base_name}_instanceProfile"
    path = "/"
    role = "${aws_iam_role.ecs-instance-role.id}"
}