
output "app_elb_public_dns" {
  value = aws_alb.ecs-load-balancer.dns_name
  description = "public dns of service LB"

}
output "cluster_name" {
  value = aws_ecs_cluster.app2_cluster.name
}
output "service_name" {
  value = aws_ecs_service.app-service-2.name
}

