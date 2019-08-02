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
    tags={"env"="dev","jira"="PHN-123"}
}
module "service_continuous_integration" {
    source = "../../../modules/ci"
    cluster_name="${module.service_app.cluster_name}"
    service_name="${module.service_app.service_name}"
    aws_resource_base_name = "${var.aws_resource_base_name}"
    vcs_repo_name="${var.vcs_repo_name}"
    vcs_repo_owner="${var.vcs_repo_owner}"
    ecr_registry_id= "${aws_ecr_repository.quest.registry_id}"
    ecr_repository_url="${aws_ecr_repository.quest.repository_url}"
    app_container_name="${var.app_container_name}"
    tags={"env"="dev","jira"="PHN-123"}
}