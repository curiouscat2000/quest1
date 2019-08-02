
/**
PRECONDITION
export GitHub private repo token as env variable
$ export GITHUB_TOKEN=YOUR_TOKEN
ref https://www.terraform.io/docs/providers/aws/r/codepipeline.html
*/
resource "aws_codepipeline" "pipeline" {
  name     = "${var.aws_resource_base_name}Pipeline${var.service_name}"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.codepipeline_bucket.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration={
        Owner      = "${var.vcs_repo_owner}"
        Repo       = "${var.vcs_repo_name}"
        Branch     = "master"
        PollForSourceChanges = "true"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source"]
      output_artifacts = ["imagedefinitions"]

      configuration={
        ProjectName = "${aws_codebuild_project.quest.name}"
      }
    }
  }

  stage {
    name = "Production"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["imagedefinitions"]
      version         = "1"

      configuration={
        ClusterName = "${var.cluster_name}"
        ServiceName = "${var.service_name}"
        FileName    = "imagedefinitions.json"
      }
    }
  }
   tags = "${merge(
    local.common_tags,
    "${var.tags}"
  )}"
}
