module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = "cluster-eks-lab-dev"
  cluster_version = "1.30"

  # Networking
  vpc_id = aws_vpc.eks_vpc.id
  subnet_ids = [
    aws_subnet.eks_private_1a.id,
    aws_subnet.eks_private_1b.id
  ]

  # IAM Role do cluster
  iam_role_arn = aws_iam_role.eks_cluster.arn

  # Node Groups gerenciados pelo EKS
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 4
      desired_size   = 2

      iam_role_arn = aws_iam_role.eks_nodes.arn

      disk_size     = 20
      capacity_type = "ON_DEMAND"

      labels = {
        role = "worker"
      }

      tags = {
        Name = "${var.project_name}-node"
      }
    }
  }

  tags = {
    Environment = "development"
    Project     = "EKS project"
  }
}
