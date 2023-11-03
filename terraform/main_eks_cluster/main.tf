# Define the provider and AWS region


# Create the VPC and subnets using the VPC module
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

# Create the EKS cluster using the EKS module
module "eks" {
  source       = "./modules/eks"
  cluster_name = "my-eks-cluster"
  #   vpc_id        = module.vpc.vpc_id
  #   subnet_ids    = module.vpc.public_subnet_ids
}


# Create the EKS node group using the EKS Node Group module
module "eks_node_group" {
  source          = "./modules/eks_node_group"
  cluster_name    = module.eks.cluster_name
  node_group_name = "my-node-group"
}


