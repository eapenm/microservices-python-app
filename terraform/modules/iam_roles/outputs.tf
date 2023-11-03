output "role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  value       = aws_iam_role.my_eks_cluster_role.arn
}
