resource "aws_iam_role_policy_attachment" "codebuild_role_attachment_0" {
    role       = "${aws_iam_role.codebuild_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
resource "aws_iam_role_policy_attachment" "codebuild_role_attachment_1" {
    role       = "${aws_iam_role.codebuild_role.name}"
    policy_arn = "${aws_iam_policy.codebuild_role_policy.arn}"
}
resource "aws_iam_role_policy_attachment" "codepipeline_role_attachment_0" {
    role       = "${aws_iam_role.codepipeline_role.name}"
    policy_arn = "${aws_iam_policy.codepipeline_role_policy.arn}"
}