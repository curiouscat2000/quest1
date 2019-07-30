resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
    role       = "${aws_iam_role.ecs-instance-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-attachment-0" {
    role       = "${aws_iam_role.ecs-task-execution-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-attachment-1" {
    role       = "${aws_iam_role.ecs-task-execution-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-attachment-2" {
    role       = "${aws_iam_role.ecs-task-execution-role.name}"
    policy_arn = "${aws_iam_policy.aws_service_discovery.arn}"
}
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-attachment-3" {
    role       = "${aws_iam_role.ecs-task-execution-role.name}"
    policy_arn = "${aws_iam_policy.aws_secrets_manager_read.arn}"
}