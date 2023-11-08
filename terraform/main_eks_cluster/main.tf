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
  source               = "../modules/eks_cluster"
  cluster_name         = var.cluster_name
  eks_cluster_role_arn = module.iam_roles.eks_cluster_role_arn
  subnet_ids           = module.vpc.subnet_ids
  project_name         = var.project_name
}


# Create the EKS node group using the EKS Node Group module
module "eks_node_group" {
  source          = "../modules/eks_node_group"
  clustername    = module.eks.cluster_name
  node_group_name = var.node_group_name
  eks_cluster_node_role_arn = module.iam_roles.eks_cluster_node_role_arn
  min_size     = var.min_size
  desired_size = var.desired_size
  max_size     = var.max_size
  instance_types = var.instance_types
  subnet_ids     = module.vpc.subnet_ids
  source_security_group_ids = module.vpc.node_security_group_id
  project_name         = var.project_name


}



