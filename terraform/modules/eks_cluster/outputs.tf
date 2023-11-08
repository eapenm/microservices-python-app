# output "cluster_config" {
#   description = "EKS cluster configuration"
#   value       = aws_eks_cluster.my_eks_cluster
# }

# output "kubeconfig" {
#   description = "Kubeconfig for the EKS cluster"
#   value       = aws_eks_cluster.my_eks_cluster.kubeconfig
# }

output "cluster_name" {
  value = aws_eks_cluster.my_eks_cluster.name
}