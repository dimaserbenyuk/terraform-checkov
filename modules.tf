# -----------------#
# AWS VPC.         #
# -----------------#

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = "${local.name}-vpc"
  cidr = "10.99.0.0/18"

  azs              = ["${var.region}a", "${var.region}b"]
  public_subnets   = ["10.99.0.0/24", "10.99.1.0/24"]
  private_subnets  = ["10.99.3.0/24", "10.99.4.0/24"]
  database_subnets = ["10.99.7.0/24", "10.99.8.0/24"]

  enable_dns_hostnames = true

  create_database_subnet_group = false

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    env        = "dev and prod"
    managed_by = "Terraform"
    project    = "Yeew"
  }

}

