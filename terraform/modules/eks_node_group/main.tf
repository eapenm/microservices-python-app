resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.clustername
    # cluster_name    = aws_eks_cluster.my_eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.eks_cluster_node_role_arn

  scaling_config {
    min_size     = var.min_size
    desired_size = var.desired_size
    max_size     = var.max_size
  }

  instance_types = var.instance_types
  subnet_ids     = var.subnets
  remote_access {
    source_security_group_ids = [var.sg_id] # Specify your security group here
  }
  update_config {
    max_unavailable = 1
  }
  tags = {
    name = "EKS-Cluster-Nodes"
  }
}