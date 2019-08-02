

resource "aws_codebuild_project" "quest" {
  name          = "${var.aws_resource_base_name}Project${var.service_name}"
  build_timeout = "10"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }
  environment {
    privileged_mode = true // for building docker images from inside docker container
    //ref https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0" //troubles with setting runtime_version when try 2.0
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"


    environment_variable {
      name  = "ECR_REPO_REGISTRY_ID"
      value = "${var.ecr_registry_id}" //"${aws_ecr_repository.quest.registry_id}"
    }
    environment_variable {
      name  = "AWS_REGION"
      value = "${data.aws_region.current.name}"
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = "${var.ecr_repository_url}" //"${aws_ecr_repository.quest.repository_url}"
    }
    environment_variable {
      name  = "CONTAINER_NAME"
      value = "${var.app_container_name}"
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name  = "${aws_cloudwatch_log_group.code_build_logs.name}"
      stream_name = "log-stream"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "${file("${var.path_2_buildspec}")}"
  }
  tags = "${merge(
    local.common_tags,
    "${var.tags}"
  )}"
}
