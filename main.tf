module "eks_vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  project     = var.project
  common_tags = var.common_tags
  vpc_cidr    = var.vpc_cidr
}