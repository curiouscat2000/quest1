resource "aws_autoscaling_group" "ecs_autoscaling_group" {
    name                        = "${var.aws_resource_base_name}_ASG"
    max_size                    = "${var.max_instance_size}"
    min_size                    = "${var.min_instance_size}"
    desired_capacity            = "${var.desired_capacity}"
    vpc_zone_identifier         = "${var.vpc_public_subnets_ids}"
    launch_configuration        = "${aws_launch_configuration.ecs-launch-configuration.name}"
    health_check_grace_period = 60
    health_check_type           = "EC2"
/**

*/
   tags = [
    {
      key                 = "contact"
      value               = "devops@company.com"
      propagate_at_launch = true
    },
    {
      key                 = "Jira"
      value               = "none"
      propagate_at_launch = true
    },
     {
      key                 = "Name"
      value               = "${var.ecs_cluster}-${var.service_name}"
      propagate_at_launch = true
    },
  ]

  }