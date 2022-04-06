resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private-subnets" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnets[count.index]

  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}

resource "aws_subnet" "public-subnets" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}