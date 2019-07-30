output "vpc_id" {
  value       = aws_vpc.ecstest2.id
  description = "VPC id"
}
output "nat_public_ip" {
  value       = aws_eip.nat.public_ip
  description = "NAT external IP"
}
output "list_public_subnets_ids"{
  value = [ aws_subnet.publicA.id, aws_subnet.publicB.id]
}
output "list_private_subnets_ids"{
  value = [ aws_subnet.privateA.id, aws_subnet.privateB.id]
}