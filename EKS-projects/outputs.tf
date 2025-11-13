output "eks_vpc" {
  value = aws_eks_cluster.eks_cluster

}

output "oidc" {
  value = module.eks_cluster.oidc_provider_arn
}

output "eks_cluster_name" {
  description = "Nome do cluster EKS"
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = module.eks_cluster.cluster_endpoint
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_nodes.arn
}
