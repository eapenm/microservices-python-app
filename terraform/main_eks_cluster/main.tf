# Define the provider and AWS region


# Create the VPC and subnets using the VPC module
module "vpc" {
  source   = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}
# IAM Roles
module "iam_roles" {
  source = "../modules/iam_roles"
}

# Create the EKS cluster using the EKS module
module "eks" {
  source       = "../modules/eks_cluster"
  eks_cluster_role_arn = module.iam_roles.cluster_role_arn
  #   vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.subnet_ids
}


# Create the EKS node group using the EKS Node Group module
module "eks_node_group" {
  source          = "../modules/eks_node_group"
  # clustername=module.eks.cluster_name
  node_group_name = "my-node-group"
  subnets = module.vpc.subnet_ids
  eks_cluster_node_role_arn=module.iam_roles.cluster_node_role_arn
  sg_id=module.vpc.node_security_group_id
}


