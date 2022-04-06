resource "aws_vpc" "vpc" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.vpc.id
  ipv4_netmask_length = 28
  depends_on = [
    aws_vpc_ipam_pool_cidr.vpc
  ]
}

resource "aws_subnet" "subnet" {
  count = length(var.subnets)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnets[count.index]
  tags {
    Name = var.name
  }
}