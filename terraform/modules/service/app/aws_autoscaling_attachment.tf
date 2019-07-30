resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.ecs_autoscaling_group.id}"
  alb_target_group_arn   = "${aws_alb_target_group.ecs-target-group.arn}"
}