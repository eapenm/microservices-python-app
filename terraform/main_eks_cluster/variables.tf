variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  #  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  # default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "project_name" {
  # description = "Microservice on EKS"  
}
variable "region" {}

# IAM Role file
variable "eks-cluster-role" {}
variable "eks-cluster-node-role" {}

# EKS Cluster
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
  type        = string
}

# Define other cluster-specific variables
variable "subnet_ids" {
  description = "Name the subnet_ids"
  type        = list(string)
}
