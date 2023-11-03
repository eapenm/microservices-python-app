resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.my_eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.my_eks_cluster_role.arn

  scaling_config {
    min_size     = var.min_size
    desired_size = var.desired_size
    max_size     = var.max_size
  }

  instance_types = var.instance_types
  subnet_ids     = aws_subnet.my_subnet[*].id
  remote_access {
    source_security_group_ids = [aws_security_group.eks_node_security_group.id] # Specify your security group here
  }
  update_config {
    max_unavailable = 1
  }
  tags = {
    name = "EKS-Cluster-Nodes"
  }
}