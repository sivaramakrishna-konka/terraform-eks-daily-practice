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
