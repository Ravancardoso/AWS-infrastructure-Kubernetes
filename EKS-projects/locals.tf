# locals

locals {
  tags = {
    environment  = "development"
    organization = "infrastructure and delevopment"
    project      = "EKS-project"
  }

  # Name Cluster 
  cluster_name = var.eks_cluster_name

  # Tags EKS
  eks_common_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }

  # Tags Subnet Públic
  public_role_tag = {
    "kubernetes.io/role/elb" = "1"
  }

  # Tags Subnet Private
  private_role_tag = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}