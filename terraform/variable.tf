########################## global vars ###########################
variable "region" {
  description = "the region name"
  type        = string
  default     = "eu-west-1"
}



########################## VPC ###########################
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "check-point-vpc"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "private_subnets" {
  description = "A list of private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "A list of public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    vpc = true
  }
}


###################################### EKS ######################################

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "orasraf-cluster"
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the Kubernetes API server endpoint"
  type        = bool
  default     = true
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node groups"
  type = map(object({
    ami_type       = string
    instance_types = list(string)
    min_size       = number
    max_size       = number
    desired_size   = number
  }))
  default = {
    checkPoint-eks = {
      ami_type       = "BOTTLEROCKET_x86_64"
      instance_types = ["t3.medium"]
      min_size       = 3
      max_size       = 6
      desired_size   = 3
    }
  }
}

######################## ALB ##########################
variable "load_balancer_controller_name" {
  description = "Name of the AWS Load Balancer Controller"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "load_balancer_controller_namespace" {
  description = "Namespace for the AWS Load Balancer Controller"
  type        = string
  default     = "kube-system"
}

variable "helm_release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "alb-ingress-controller"
}

variable "helm_repository_url" {
  description = "Repository URL for the Helm chart"
  type        = string
  default     = "https://aws.github.io/eks-charts"
}

variable "helm_chart_name" {
  description = "Name of the Helm chart"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "alb_ingress_policy_name" {
  description = "Name of the IAM policy for ALB Ingress Controller"
  type        = string
  default     = "ALBIngressControllerIAMPolicy"
}

variable "alb_ingress_role_name" {
  description = "Name of the IAM role for ALB Ingress Controller"
  type        = string
  default     = "eks-alb-ingress-controller-role"
}