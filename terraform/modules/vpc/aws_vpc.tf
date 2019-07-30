resource "aws_vpc" "ecstest2" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true 

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "${var.aws_resource_base_name}-vpc"
    )
  )}"
}
