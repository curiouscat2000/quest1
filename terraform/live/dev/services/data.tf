
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "k-test-terraform-state-2"
    key            = "dev/vpc/terraform.tfstate"
  }
}


data "aws_region" "current" {}