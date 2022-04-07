resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public-subnets" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets[count.index].cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnets[count.index].zone != null ? var.public_subnets[count.index].zone : null

  tags = {
    Name = "${var.name}-public-${count.index}",
  }
}

resource "aws_subnet" "private-subnets" {
  count = length(var.private_subnets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets[count.index].cidr_block
  map_public_ip_on_launch = false
  availability_zone       = var.private_subnets[count.index].zone != null ? var.private_subnets[count.index].zone : null

  tags = {
    Name = "${var.name}-private-${count.index}",
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr_blocks" {
  count = length(var.secondary_cidr_blocks)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.secondary_cidr_blocks[count.index]
}

resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-internet-gateway"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
}

resource "aws_route_table_association" "route-table-association" {
  count = length(aws_subnet.public-subnets)

  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.route-table.id
}