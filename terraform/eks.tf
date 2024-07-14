module "eks" {
  # Source module for creating EKS clusters
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  # EKS Cluster name and version, sourced from variables
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Control public access to the EKS cluster endpoint
  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  # EKS cluster addons, configured with default settings
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  # VPC configuration: VPC ID and subnets for the EKS cluster
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  # Node Group definition: managed node groups configuration
  eks_managed_node_groups = var.eks_managed_node_groups

  # Enable cluster creator admin permissions to allow the creator admin access to the cluster
  enable_cluster_creator_admin_permissions = true

  # Tags for identifying the EKS resources
  tags = {
    resource  = "eks"
    Terraform = "true"
  }

  iam_role_name = aws_iam_role.checkpoint_eks_eks_node_group.name
}

resource "aws_iam_role" "checkpoint_eks_eks_node_group" {
  name = "checkpoint-eks-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

}
