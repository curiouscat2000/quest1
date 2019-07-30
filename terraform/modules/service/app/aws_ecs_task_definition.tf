/**
by default, ECS pickups docker image with "latest" tag
*/
resource "aws_ecs_task_definition" "app2" {
  family                = "app2"
  task_role_arn         = "${aws_iam_role.ecs-task-execution-role.arn}"
  execution_role_arn    = "${aws_iam_role.ecs-task-execution-role.arn}"
  depends_on            = ["aws_cloudwatch_log_group.app2"]
  container_definitions = <<DEFINITION
[
  {
	"image": "${var.service_docker_image}",
	"name": "${var.app_container_name}",
	"requiresCompatibilities": [
		"EC2"
	],
	"networkMode": "bridge",
	"essential": true,
	"logConfiguration": {
		"logDriver": "awslogs",
		"secretOptions": null,
		"options": {
			"awslogs-group": "${aws_cloudwatch_log_group.app2.name}",
			"awslogs-region": "${data.aws_region.current.name}",
			"awslogs-stream-prefix": "ecs"
		}
	},
	"portMappings": [{
		"containerPort": ${var.container_port},
		"hostPort": 0
	}],
	"memory": 256,
	"cpu": 0,
	"environment": [{
		"name": "SECRET_WORD",
		"value": "${var.SECRET_WORD}"}
	]
}
]
DEFINITION

tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}Task"
    )
  )}"
}
