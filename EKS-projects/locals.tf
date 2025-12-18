# locals

locals {
  environment_tags = {
    Environment = "dev"
  }

  default_tags = {
    Project     = "EKS-project"
    Owner       = "Ravan Cardoso"
    ManagedBy   = "Terraform"
    Departament = "Devops"
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