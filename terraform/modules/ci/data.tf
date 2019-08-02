data "aws_region" "current" {}


data aws_iam_policy_document "codebuild_role_assume_policy"{
  statement {
      actions = ["sts:AssumeRole"]
      principals {
          type        = "Service"
          identifiers = ["codebuild.amazonaws.com"]
      }
  }
}

data aws_iam_policy_document "codepipeline_role_assume_policy"{
  statement {
      actions = ["sts:AssumeRole"]
      principals {
          type        = "Service"
          identifiers = ["codepipeline.amazonaws.com"]
      }
  }
}
