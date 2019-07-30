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