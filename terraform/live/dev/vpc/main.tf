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
    key            = "dev/vpc/terraform.tfstate"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "poc-terraform-state-locks"
    encrypt        = true
  }
}

module "vpc" {
  source = "../../../modules/vpc"
  aws_resource_base_name="APP"
  region="${data.aws_region.current.name}"
}
