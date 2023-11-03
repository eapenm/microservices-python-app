variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default = "my-eks-cluster"
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  type        = string
}

# Define other cluster-specific variables
variable "subnet_ids"{
  description = "Name the subnet_ids"
  type=list(string)
}