resource "aws_cloudwatch_metric_alarm" "example_cpu_alarm" {
alarm_name = "${var.aws_resource_base_name}_cpu_alarm_up"
alarm_description = "cpu-alarm"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = "30"
dimensions = {
"AutoScalingGroupName" = "${aws_autoscaling_group.ecs_autoscaling_group.name}"
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.cpu_policy_up.arn}"]
}



resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scaledown" {
alarm_name = "${var.aws_resource_base_name}_cpu_alarm_scaledown"
alarm_description = "cpu_alarm_scaledown"
comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "120"
statistic = "Average"
threshold = "5"
dimensions = {
"AutoScalingGroupName" = "${aws_autoscaling_group.ecs_autoscaling_group.name}"
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.cpu_policy_scaledown.arn}"]
}