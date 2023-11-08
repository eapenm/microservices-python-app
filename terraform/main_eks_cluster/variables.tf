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