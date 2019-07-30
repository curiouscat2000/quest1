/**
role for ECS service, service linked, to conditionally create if not exists
perms:
N/A, managed by AWS, just create the role with predefined name if not exists yet 
ManagedAWSPolciy if any
- AmazonECSServiceRolePolicy
*/
/**
@TODO


resource "aws_iam_role" "ecs-service-role" {
    name                = "ecs-service-role"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.ecs-service-policy.json}"
}
*/
/**
@ref  https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html#create-service-linked-role
*/
resource "aws_iam_service_linked_role" "ecs" {
  count ="${var.create_ecs_service_linked_role ? 1 : 0}"
  aws_service_name = "ecs.amazonaws.com"
}


/**
role for EC2 instance to run ECS agent 
perms:
- download image from ECR
- download image from private container repo if any
- register instance in ECS service
- log events
Managed AWS policy if any:
- AmazonEC2ContainerServiceforEC2Role
Note
- usable by ANY container run inside this instance as also any code deployed there
*/

resource "aws_iam_role" "ecs-instance-role" {
    name                = "${var.aws_resource_base_name}_ecsInstanceRole"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.ecs-instance-policy.json}"
    tags = local.common_tags
}

/**
TaskExectionRole to be to be assumed by ecs agent 
Perms:
- read secrets if any
- read configs if any
Managed AWS policy if any:
- AmazonECSTaskExecutionRolePolicy
*/

resource "aws_iam_role" "ecs-task-execution-role" {
    name                = "${var.aws_resource_base_name}_ecsTaskExecutionRole"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.ecs-task-exec-policy.json}"
    tags = local.common_tags

}

/**
TaskRun Role to be used by app container when need
Managed AWS policy if any:
- none
Perms:
- none if app container does not call AWS services
*/
/**
No need yet
*/
/**
application autoscaling role to be used by ECS auto scaling to start/stop containers
*/
/**
@tbd
*/

