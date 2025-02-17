
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name = local.vpc_name

  cidr = var.vpc_cidr_block
  azs  = ["${var.region}a", "${var.region}b"]

  public_subnets = [
    cidrsubnet(var.vpc_cidr_block, 1, 0), # First /25 subnet
    cidrsubnet(var.vpc_cidr_block, 1, 1)  # Second /25 subnet
  ]
  public_subnet_tags = {
    network_tier = "public"
    managed_by   = "Terraform"
    env          = var.env
    project      = var.project
  }

  enable_dns_hostnames    = true
  enable_dns_support      = true
  enable_ipv6             = false
  map_public_ip_on_launch = true

  tags = {
    Name       = local.vpc_name
    managed_by = "Terraform"
    env        = var.env
    project    = var.project
  }
}