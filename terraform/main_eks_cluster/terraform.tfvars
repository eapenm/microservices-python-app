region       = "us-east-1"
vpc_cidr     = "10.0.0.0/16"
subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
project_name = "Microservice on EKS"

#IAM role
eks-cluster-role      = "my-eks-cluster-role"
eks-cluster-node-role = "my-eks-cluster-node-role"
# EKS Cluster

cluster_name = "my-eks-cluster"

#EKS Node
node_group_name = "nodes"
min_size     = 3
desired_size = 3
max_size     = 5
instance_types = ["t2.large"]

