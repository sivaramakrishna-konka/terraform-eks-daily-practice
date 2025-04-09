variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}
variable "eks_version" {
  description = "EKS version"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}