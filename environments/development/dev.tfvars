environment = "dev"
project     = "eks"
common_tags = {
  "Environment" = "development"
  "Project"     = "eks"
  "Owner"       = "sivaramakrishna"
  "Terraform"   = "v1.11.3"
  "ManagedBy"   = "Terraform"
  "AWS Version" = "5.94.1"
}
vpc_cidr = "10.1.0.0/16"

azs = ["ap-south-1a","ap-south-1b"]
public_subnet_cidr = ["10.1.1.0/24","10.1.2.0/24"]
private_subnet_cidr = ["10.1.4.0/24","10.1.5.0/24"]
db_subnet_cidr = ["10.1.8.0/24","10.1.9.0/24"]
enable_nat = false
# enable_instance_connect = true