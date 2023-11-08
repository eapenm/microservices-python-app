# Define the provider and AWS region


# Create the VPC and subnets using the VPC module
module "vpc" {
  source       = "../modules/vpc"
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  project_name = var.project_name
}
# IAM Roles
module "iam_roles" {
  source                = "../modules/iam_roles"
  eks-cluster-role      = var.eks-cluster-role
  eks-cluster-node-role = var.eks-cluster-node-role
}


# Create the EKS cluster using the EKS module
module "eks" {
  source       = "../modules/eks"
  cluster_name = "my-eks-cluster"
  #   vpc_id        = module.vpc.vpc_id
  #   subnet_ids    = module.vpc.public_subnet_ids
}


# # Create the EKS node group using the EKS Node Group module
# module "eks_node_group" {
#   source          = "./modules/eks_node_group"
#   cluster_name    = module.eks.cluster_name
#   node_group_name = "my-node-group"
# }



