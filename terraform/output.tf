
output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "cluster_name" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_name
}


############ vpc output ###############
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "The public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "The private subnets"
  value       = module.vpc.private_subnets
}


