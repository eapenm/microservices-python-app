resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.clustername
  node_group_name = var.node_group_name
  node_role_arn   = var.eks_cluster_node_role_arn

  scaling_config {
    min_size     = var.min_size
    desired_size = var.desired_size
    max_size     = var.max_size
  }

  instance_types = var.instance_types
  subnet_ids     = var.subnet_ids
  # remote_access {
  #   #ec2SshKey = "Robin"
  #   source_security_group_ids = [var.source_security_group_ids] # Specify your security group here
  # }
  update_config {
    max_unavailable = 1
  }
  tags = {
    name = "${var.project_name}-EKS-Cluster-Nodes"
  }
}