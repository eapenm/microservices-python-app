# Define the provider and AWS region


# Create the VPC and subnets using the VPC module
module "vpc" {
<<<<<<< Updated upstream
  source   = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
=======
  source       = "../modules/vpc"
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  project_name = var.project_name
>>>>>>> Stashed changes
}
# IAM Roles
module "iam_roles" {
  source = "../modules/iam_roles"
}

<<<<<<< Updated upstream
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
=======
# # Create the EKS cluster using the EKS module
# module "eks" {
#   source       = "./modules/eks"
#   cluster_name = "my-eks-cluster"
#   #   vpc_id        = module.vpc.vpc_id
#   #   subnet_ids    = module.vpc.public_subnet_ids
# }


# # Create the EKS node group using the EKS Node Group module
# module "eks_node_group" {
#   source          = "./modules/eks_node_group"
#   cluster_name    = module.eks.cluster_name
#   node_group_name = "my-node-group"
# }
>>>>>>> Stashed changes


