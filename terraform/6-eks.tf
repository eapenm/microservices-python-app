resource "aws_iam_role" "ekscluster" {
  name = "eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "ekscluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.ekscluster.name
}

variable "cluster_name" {
  default     = "ekscluster"
  type        = string
  description = "AWS EKS CLuster Name"
  nullable    = false
}

resource "aws_eks_cluster" "ekscluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.ekscluster.arn
  version  = "1.21" # Replace with your desired EKS version

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.ekscluster-AmazonEKSClusterPolicy]
}

# Retrieve secrets from external source (e.g., AWS Secrets Manager)
data "aws_secretsmanager_secret_version" "my_secret" {
  secret_id = "my-secret-id" # Replace with your secret ID
}

# Extract the sensitive values from the secret data
locals {
  admin_password = jsondecode(data.aws_secretsmanager_secret_version.my_secret.secret_string)["admin_password"]
}

# Install Prometheus operator
resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-operator"
  version    = "9.4.4"

  namespace = "monitoring"

  set {
    name  = "prometheusOperator.createCustomResource"
    value = "false"
  }
}

# Install Grafana
resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.15.0"

  namespace = "monitoring"

  set {
    name  = "adminPassword"
    value = local.admin_password # Use the extracted admin password from the secret
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
}

# Configure Prometheus datasource in Grafana
resource "grafana_data_source" "prometheus_datasource" {
  name        = "prometheus"
  type        = "prometheus"
  access_mode = "proxy"
  url         = "http://prometheus-operated.monitoring.svc.cluster.local"

  jsonData {
    timeInterval = "5s"
  }
}

# Add Prometheus and Grafana to EKS cluster RBAC
resource "kubernetes_cluster_role" "prometheus_grafana_cluster_role" {
  metadata {
    name = "prometheus-grafana-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "prometheus_grafana_cluster_role_binding" {
  metadata {
    name = "prometheus-grafana-cluster-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.prometheus_grafana_cluster_role.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "monitoring"
  }
}