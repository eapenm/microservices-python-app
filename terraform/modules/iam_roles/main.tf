resource "aws_iam_role" "my_eks_cluster_role" {
  name = var.eks-cluster-role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "AmazonEKSVPCResourceController_attachment" {
  name       = "AmazonEKSVPCResourceController_attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  roles      = [aws_iam_role.my_eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "AmazonEKSServicePolicy_attachment" {
  name       = "AmazonEKSServicePolicy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  roles      = [aws_iam_role.my_eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy_attachment" {
  name       = "AmazonEKSClusterPolicy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.my_eks_cluster_role.name]
}

# IAM role for node group

resource "aws_iam_role" "my_eks_cluster_node_role" {
  name = var.eks-cluster-node-role
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.my_eks_cluster_node_role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.my_eks_cluster_node_role.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.my_eks_cluster_node_role.name
}
