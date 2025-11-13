module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name = var.project_name
  vpc_id       = aws_vpc.eks_vpc.id
  subnet_ids = [
    aws_subnet.eks_private_1a.id,
    aws_subnet.eks_private_1b.id
  ]

  # role name
  iam_role_arn = aws_iam_role.eks_cluster.arn


  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 4
      desired_size   = 2
      iam_role_arn   = aws_iam_role.eks_nodes.arn

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
    Environment = var.eks_cluster_name
    Project     = var.project_name
  }
}
