output "vpc_id" {
  value = module.eks_vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.eks_vpc.public_subnet_ids
}