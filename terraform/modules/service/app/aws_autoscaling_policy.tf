resource "aws_autoscaling_policy" "cpu_policy_up" {
name = "${var.aws_resource_base_name}_cpu_policy"
autoscaling_group_name = "${aws_autoscaling_group.ecs_autoscaling_group.name}"
adjustment_type = "ChangeInCapacity"
scaling_adjustment = "1"
cooldown = "300"
policy_type = "SimpleScaling"
}


resource "aws_autoscaling_policy" "cpu_policy_scaledown" {
name = "${var.aws_resource_base_name}_cpu_policy_scaledown"
autoscaling_group_name = "${aws_autoscaling_group.ecs_autoscaling_group.name}"
adjustment_type = "ChangeInCapacity"
scaling_adjustment = "-1"
cooldown = "300"
policy_type = "SimpleScaling"
}