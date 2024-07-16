########################## Global Vars ###########################
# The region where AWS resources will be created
region = "eu-west-1"

########################## VPC ###########################
# The name of the VPC
vpc_name = "orasraf-project-vpc"

# The CIDR block for the VPC
cidr = "10.0.0.0/16"

# A list of availability zones in the region
azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

# A list of private subnets within the VPC
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

# A list of public subnets within the VPC
public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

# Boolean to enable NAT Gateway
enable_nat_gateway = true

# Boolean to enable VPN Gateway
enable_vpn_gateway = true

# A map of tags to assign to the VPC resource
tags = {
  vpc = true
}

###################################### EKS ######################################
# The name of the EKS cluster
cluster_name = "orasraf-cluster"

# The Kubernetes version for the EKS cluster
cluster_version = "1.28"

# Boolean to enable public access to the Kubernetes API server endpoint
cluster_endpoint_public_access = true

# Map of EKS managed node groups configuration
eks_managed_node_groups = {
  checkPoint-eks = {
    ami_type       = "BOTTLEROCKET_x86_64"
    instance_types = ["t3.medium"]
    min_size       = 3
    max_size       = 6
    desired_size   = 3
  }
}

######################## ALB ##########################
# Name of the AWS Load Balancer Controller
load_balancer_controller_name = "aws-load-balancer-controller"

# Namespace for the AWS Load Balancer Controller
load_balancer_controller_namespace = "kube-system"

# Name of the Helm release
helm_release_name = "alb-ingress-controller"

# Repository URL for the Helm chart
helm_repository_url = "https://aws.github.io/eks-charts"

# Name of the Helm chart
helm_chart_name = "aws-load-balancer-controller"

# Name of the IAM policy for ALB Ingress Controller
alb_ingress_policy_name = "ALBIngressControllerIAMPolicy"

# Name of the IAM role for ALB Ingress Controller
alb_ingress_role_name = "eks-alb-ingress-controller-role"
