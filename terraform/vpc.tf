module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"


  # Name of the VPC
  name = var.vpc_name

  # CIDR block for the VPC
  cidr = var.cidr

  # Availability zones in the region
  azs = var.azs

  # Private subnets within the VPC
  private_subnets = var.private_subnets

  # Public subnets within the VPC
  public_subnets = var.public_subnets

  # Boolean to enable NAT Gateway
  enable_nat_gateway = var.enable_nat_gateway

  # Tags to assign to the VPC resource
  tags = var.tags
}
