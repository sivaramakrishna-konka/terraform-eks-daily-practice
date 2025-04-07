environment = "development"
project     = "eks"
common_tags = {
  "Environment" = "development"
  "Project"     = "eks"
  "Owner"       = "sivaramakrishna"
}
vpc_cidr = "10.1.0.0/16"

azs = ["ap-south-1a","ap-south-1b"]
public_subnet_cidr = ["10.1.1.0/24","10.1.2.0/24"]
private_subnet_cidr = ["10.1.4.0/24","10.1.5.0/24"]
