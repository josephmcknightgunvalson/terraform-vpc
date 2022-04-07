resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnets" {
  count = length(var.subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets[count.index].cidr_block
  map_public_ip_on_launch = var.subnets[count.index].public
  availability_zone       = var.subnets[count.index].zone != null ? var.subnets[count.index].zone : null

  tags = {
    Name = "${var.name}-${count.index}"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr_blocks" {
  count = length(var.secondary_cidr_blocks)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.secondary_cidr_blocks[count.index]
}