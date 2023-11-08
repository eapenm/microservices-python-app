output "eks_cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  value       = aws_iam_role.my_eks_cluster_role.arn
}

output "eks_cluster_node_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  value       = aws_iam_role.my_eks_cluster_node_role.arn
}