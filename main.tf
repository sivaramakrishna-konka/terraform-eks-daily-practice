module "eks_vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  project     = var.project
  common_tags = var.common_tags
  vpc_cidr    = var.vpc_cidr
  azs         = var.azs
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  db_subnet_cidr = var.db_subnet_cidr
}