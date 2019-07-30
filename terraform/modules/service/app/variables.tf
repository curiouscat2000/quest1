variable "ecs_cluster" {
  description = "ECS cluster name"
  default = "app2"
}

variable "ecs_key_pair_name" {
  description = "EC2 instance key pair name"
}

########################### Autoscale Config ################################

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
  default = 6
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
  default = 2
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
  default = 2
}

variable "developer_ip" {
  description = "source IP of developer"
  type = "string"
}

variable "service_name" {
  description = "ECS Service Name"
  type = "string"
  default = "app2"
}
variable "service_app_instance_type" {
  type="string"
}


variable "region" {
  description = "AWS region"
  type = "string"
}

variable "app_container_name"{
  type="string"
} 


variable "aws_resource_base_name"{
  description = "base name for AWS resources"
  type = "string"
  default ="app2"
}

variable "container_port"{
  description = "container TCP port to listen"
  type = number

}

variable "vpc_id" {
  type="string"
  description = "What VPC to creat the service in?"
}

variable "vpc_public_subnets_ids" {
  type=list(string)
}

variable "SECRET_WORD" {
  type=string
  description="see test steps"
}
variable "create_ecs_service_linked_role" {
  default=false
}

variable "ssl_cert_arn" {
    description="ARN of SSL cert uploaded to ACM"
}

variable "ecr_repository_name" {
   default = "quest"
   type=string
   description="name of ECR repository, excluding hostname"
}

variable "service_docker_image" {
  description="full url of docker image to download and execute. If no tag supplied, latest will be picked up"
  type=string
}
