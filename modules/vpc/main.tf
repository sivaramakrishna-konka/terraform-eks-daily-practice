locals {
  name  = "${var.environment}-${var.project}"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
    )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
    )
}

###############################################################################
# Subnets
###############################################################################
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    {
      Name = "${local.name}-public-subnet-${split("-", var.azs[count.index])[2]}"
    },
    var.common_tags
    )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
    {
      Name = "${local.name}-private-subnet-${split("-", var.azs[count.index])[2]}"
    },
    var.common_tags
    )
}

resource "aws_subnet" "db" {
  count = length(var.db_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = merge(
    {
      Name = "${local.name}-db-subnet-${split("-", var.azs[count.index])[2]}"
    },
    var.common_tags
    )
}

resource "aws_db_subnet_group" "default" {
  name       = local.name
  subnet_ids = [for s in aws_subnet.db : s.id]
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
    )
}