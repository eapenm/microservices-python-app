
variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "List of EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "subnet_ids" {
  description = "List of subnet IDs where nodes will be placed"
  type        = list(string)
}

variable "clustername"{
  description = "EKS Cluster name"
  type= string
  default = "my-eks-cluster"
}
variable "eks_cluster_node_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  type        = string
}

variable "source_security_group_ids" {
  description = "Name of the security group id"
  type        = string
}
variable "project_name" {}