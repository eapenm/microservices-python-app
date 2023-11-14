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

data "aws_eks_cluster" "my_eks_cluster" {
  name = var.clustername
}

resource "aws_security_group_attachment" "my_eks_cluster_attachment" {
  security_group_id    = var.source_security_group_ids
  resource_id          = data.aws_eks_cluster.my_eks_cluster.node_group[0].id # Adjust as needed based on your EKS configuration
  security_group_id_v2 = var.source_security_group_ids
}