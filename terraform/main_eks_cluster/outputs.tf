# Define output values
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_ids" {
  value = module.eks.cluster_security_group_ids
}

output "eks_node_group_name" {
  value = module.eks_node_group.node_group_name
}