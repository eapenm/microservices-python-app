
variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "nodes"
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

variable "subnets" {
  description = "List of subnet IDs where nodes will be placed"
  type        = list(string)
}
