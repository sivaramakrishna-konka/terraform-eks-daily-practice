##################################################################################
# Provider Variables
##################################################################################
variable "region" {
  description = "The AWS region to deploy the VPC"
  type        = string
  default     = "ap-south-1"
}
variable "profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = "eks-siva.bapatlas.site"
}

###################################################################################
# Common Variables
###################################################################################
variable "environment" {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  type        = string
}
variable "project" {
  description = "The project name for the VPC"
  type        = string
}
variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

####################################################################################
# VPC Variables
####################################################################################

variable "vpc_cidr" {
  description = "value of the VPC CIDR block"
  type        = string
}

#########################################################################
# Subnet Variables
#########################################################################
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = list(string)
}
variable "azs" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}
variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}
variable "db_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = list(string)
}
variable "enable_nat" {
  type    = bool
  default = true
}
# variable "enable_instance_connect" {
#   description = "Enable EC2 Instance Connect Endpoint"
#   type        = bool
#   default     = true
# }