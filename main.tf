module "eks_vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  project     = var.project
  common_tags = var.common_tags
  vpc_cidr    = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  azs         = var.azs
}