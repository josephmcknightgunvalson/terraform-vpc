resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "subnet" {
  count = length(var.subnets)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnets[count.index]

  tags = {
    Name = "${var.name}-${count.index}"
  }
}