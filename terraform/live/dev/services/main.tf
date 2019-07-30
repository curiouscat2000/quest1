terraform {
  required_version = ">= 0.12"
}

# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
}

locals {
  common_tags = {
    Jira = "none",
    POC ="true",
    contact = "devops@company.com"
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "k-test-terraform-state-2"
    key            = "dev/services/terraform.tfstate"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "poc-terraform-state-locks"
    encrypt        = true
  }
}

resource "aws_ecr_repository" "quest" {
  name = "${var.ecr_repo_name}"
}

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


  // template = "${file("${path.module}/buildspec.yml")}"

resource "aws_iam_policy" "codebuild_role_policy"{
  name        = "${var.aws_resource_base_name}CodeBuildRolePolicy"
  description = "non fine tuend CodeBuild service grants"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CloudWatchLogsPolicy",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "CodeCommitPolicy",
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "S3GetObjectPolicy",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "S3PutObjectPolicy",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "ECRPullPolicy",
      "Effect": "Allow",
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "ECRAuthPolicy",
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Sid": "S3BucketIdentity",
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketAcl",
        "s3:GetBucketLocation"
      ],
      "Resource": 
        "*"
    },
    {
    "Effect": "Allow",
    "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:CreateNetworkInterfacePermission"
    ],
    "Resource": "*"
  }
    
  ]
}
EOF
}


resource "aws_iam_policy" "codepipeline_role_policy"{
  name        = "${var.aws_resource_base_name}CodePipelineRolePolicy"
  description = "non fine tuned CodePileine service grants"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEqualsIfExists": {
                    "iam:PassedToService": [
                        "cloudformation.amazonaws.com",
                        "elasticbeanstalk.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Action": [
                "codecommit:CancelUploadArchive",
                "codecommit:GetBranch",
                "codecommit:GetCommit",
                "codecommit:GetUploadArchiveStatus",
                "codecommit:UploadArchive"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetApplication",
                "codedeploy:GetApplicationRevision",
                "codedeploy:GetDeployment",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "elasticbeanstalk:*",
                "ec2:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "cloudwatch:*",
                "s3:*",
                "sns:*",
                "cloudformation:*",
                "rds:*",
                "sqs:*",
                "ecs:*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "lambda:InvokeFunction",
                "lambda:ListFunctions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "opsworks:CreateDeployment",
                "opsworks:DescribeApps",
                "opsworks:DescribeCommands",
                "opsworks:DescribeDeployments",
                "opsworks:DescribeInstances",
                "opsworks:DescribeStacks",
                "opsworks:UpdateApp",
                "opsworks:UpdateStack"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "cloudformation:CreateStack",
                "cloudformation:DeleteStack",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "cloudformation:CreateChangeSet",
                "cloudformation:DeleteChangeSet",
                "cloudformation:DescribeChangeSet",
                "cloudformation:ExecuteChangeSet",
                "cloudformation:SetStackPolicy",
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Effect": "Allow",
            "Action": [
                "devicefarm:ListProjects",
                "devicefarm:ListDevicePools",
                "devicefarm:GetRun",
                "devicefarm:GetUpload",
                "devicefarm:CreateUpload",
                "devicefarm:ScheduleRun"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "servicecatalog:ListProvisioningArtifacts",
                "servicecatalog:CreateProvisioningArtifact",
                "servicecatalog:DescribeProvisioningArtifact",
                "servicecatalog:DeleteProvisioningArtifact",
                "servicecatalog:UpdateProduct"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:ValidateTemplate"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeImages"
            ],
            "Resource": "*"
        }
    ]
}


EOF
}

resource aws_iam_role "codebuild_role"{
  name                = "${var.aws_resource_base_name}CodeBuildRole"
  path                = "/service-role/"
  assume_role_policy  = "${data.aws_iam_policy_document.codebuild_role_assume_policy.json}"
  tags = local.common_tags
}
resource "aws_iam_role_policy_attachment" "codebuild_role_attachment_0" {
    role       = "${aws_iam_role.codebuild_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
resource "aws_iam_role_policy_attachment" "codebuild_role_attachment_1" {
    role       = "${aws_iam_role.codebuild_role.name}"
    policy_arn = "${aws_iam_policy.codebuild_role_policy.arn}"
}
resource aws_iam_role "codepipeline_role"{
  name                = "${var.aws_resource_base_name}CodePipelinedRole"
  path                = "/service-role/"
  assume_role_policy  = "${data.aws_iam_policy_document.codepipeline_role_assume_policy.json}"
  tags = local.common_tags
}
resource "aws_iam_role_policy_attachment" "codepipeline_role_attachment_0" {
    role       = "${aws_iam_role.codepipeline_role.name}"
    policy_arn = "${aws_iam_policy.codepipeline_role_policy.arn}"
}
resource "aws_cloudwatch_log_group" "code_build_logs" {
  name = "${var.aws_resource_base_name}/codebuild/logs"
  tags = local.common_tags
}
resource "aws_codebuild_project" "quest" {
  name          = "${var.aws_resource_base_name}QuestProject"
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
      value = "${aws_ecr_repository.quest.registry_id}"
    }
    environment_variable {
      name  = "AWS_REGION"
      value = "${data.aws_region.current.name}"
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = "${aws_ecr_repository.quest.repository_url}"
    }
     environment_variable {
      name  = "CONTAINER_NAME"
      value = "${var.app_container_name}"
    }
  }
  logs_config {
    cloudwatch_logs {
      group_name = "${aws_cloudwatch_log_group.code_build_logs.name}"
      stream_name = "log-stream"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = "${file("buildspec.yml")}"
  }
  tags = local.common_tags
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket_prefix  = "${var.aws_resource_base_name}codepipeline"
  acl    = "private"
  force_destroy = true
  tags = local.common_tags
}
/**
PRECONDITION
export GitHub private repo token as env variable
$ export GITHUB_TOKEN=YOUR_TOKEN
ref https://www.terraform.io/docs/providers/aws/r/codepipeline.html
*/
resource "aws_codepipeline" "pipeline" {
  name     = "${var.aws_resource_base_name}Pipeline"
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
        ClusterName = "${module.service_app.cluster_name}"
        ServiceName = "${module.service_app.service_name}"
        FileName    = "imagedefinitions.json"
      }
    }
  }
  tags = local.common_tags
}


module "service_app" {
    source = "../../../modules/service/app"
    vpc_id="${data.terraform_remote_state.vpc.outputs.vpc_id}"
    region="${data.aws_region.current.name}"
    app_container_name="${var.app_container_name}"
    service_app_instance_type = "t3.micro"
    developer_ip="${var.developer_ip}"
    service_docker_image="${aws_ecr_repository.quest.repository_url}:latest"
    SECRET_WORD="${var.SECRET_WORD}"
    container_port = "${var.container_port}"
    ecs_key_pair_name = "${aws_key_pair.ec2_ssh_keypair.key_name}"
    ssl_cert_arn = "${aws_iam_server_certificate.test_site_com.arn}"
    vpc_public_subnets_ids = "${data.terraform_remote_state.vpc.outputs.list_public_subnets_ids}"
}