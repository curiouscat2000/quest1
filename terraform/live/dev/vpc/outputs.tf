output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC id"
}
output "nat_ip" {
  value       = module.vpc.nat_public_ip
  description = "NAT external IP"
}
output "list_public_subnets_ids"{
  value = module.vpc.list_public_subnets_ids
}
output "list_private_subnets_ids"{
  value = module.vpc.list_private_subnets_ids
}