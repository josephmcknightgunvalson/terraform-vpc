resource "aws_vpc_ipam" "vpc" {
  operating_regions {
    region_name = var.region
  }
}

resource "aws_vpc_ipam_pool" "vpc" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.vpc.private_default_scope_id
  locale         = var.region
}

resource "aws_vpc_ipam_pool_cidr" "vpc" {
  ipam_pool_id = aws_vpc_ipam_pool.vpc.id
  cidr         = var.cidr_block
}

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
}