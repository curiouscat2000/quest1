
variable "app_container_name" {
  type="string"
  description="docker container name"
}
variable "docker_image" {
  description="full name of docker image to run in ECS, suitable for 'docker pull'"
}
variable "container_port" {
  description="what port container(not HOST) listens. Assuming Bridge network mode"
}

variable "developer_ip" {
  description="IP of devops. Will be opened in Sec Group for ssh(22) on ECS instances"
}
variable "SECRET_WORD" {
  description="see test steps"
}

variable "vcs_repo_name" {
  description="GIT repo name"
}
variable "vcs_repo_owner"{
  description="Github repo owner"
}
variable "vcs_repo_type" {
  type=string
  description="valid values: GITHUB, GITHUB_ENTERPRISE"
  default="GITHUB"
}
variable "vcs_repo_auth_type" {
  type=string
  description=" The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. Valid values include PERSONAL_ACCESS_TOKEN and BASIC_AUTH "
  default="PERSONAL_ACCESS_TOKEN"
}

variable "ecr_repo_name" {
  type=string
  description="name for ECR repo to be created"
}
variable "aws_resource_base_name" {
  type="string"
  default="app2"
  description="prefix for autogenerated names of AWS assets"
}