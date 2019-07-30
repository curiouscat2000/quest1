output "app_elb_public_dns" {
  value = "${module.service_app.app_elb_public_dns}"
}
output "ecr_repo_url" {
  value = "${aws_ecr_repository.quest.repository_url}"
}
output "ecr_repo_registry_id" {
  value = "${aws_ecr_repository.quest.registry_id}"
}
