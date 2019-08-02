resource aws_iam_role "codebuild_role" {
  name               = "${var.aws_resource_base_name}CodeBuildRole${var.service_name}"
  path               = "/service-role/"
  assume_role_policy = "${data.aws_iam_policy_document.codebuild_role_assume_policy.json}"
  tags = "${merge(
    local.common_tags,
    "${var.tags}"
  )}"
}

resource aws_iam_role "codepipeline_role" {
  name               = "${var.aws_resource_base_name}CodePipelinedRole${var.service_name}"
  path               = "/service-role/"
  assume_role_policy = "${data.aws_iam_policy_document.codepipeline_role_assume_policy.json}"
  tags = "${merge(
    local.common_tags,
    "${var.tags}"
  )}"
}
