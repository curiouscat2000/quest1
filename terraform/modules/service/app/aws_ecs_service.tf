
resource "aws_ecs_service" "app-service-2" {
  	name            = "${var.aws_resource_base_name}_${var.service_name}"
  	//iam_role        = "arn:aws:iam::023655454494:role/aws-service-role/ecs.amazonaws.com/AWSServiceRoleForECS"
  	cluster         = "${aws_ecs_cluster.app2_cluster.id}"
    depends_on      = ["aws_alb_listener.alb-listener"]
    //depends_on      = ["aws_iam_role_policy_attachment.ecs-service-role-attachment"]
    scheduling_strategy = "REPLICA"
    health_check_grace_period_seconds  = 15
    deployment_maximum_percent         = 200
    deployment_minimum_healthy_percent = 50
    /**
    ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
    }*/
    /*
    placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
    }*/
  	task_definition = "${aws_ecs_task_definition.app2.arn}"
  	desired_count   = 4
    lifecycle {
      ignore_changes = ["desired_count"]
    }

  	load_balancer {
    	target_group_arn  = "${aws_alb_target_group.ecs-target-group.arn}"
    	container_port    = "${var.container_port}"
    	container_name    = "${var.app_container_name}"
	}
  tags = local.common_tags
}
