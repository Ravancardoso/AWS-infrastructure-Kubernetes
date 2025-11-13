# output.tf

output "eks_public_a" {
  description = "Public subnet a"
  value       = aws_subnet.eks_public_a.id
}

output "eks_public_b" {
  description = "Public subnet b"
  value       = aws_subnet.eks_public_b.id
}

output "eks_private_1a" {
  description = "Private subnet 1a"
  value       = aws_subnet.eks_private_1a.id
}

output "eks_private_1b" {
  description = "Private subnet 1b"
  value       = aws_subnet.eks_private_1b.id
}

output "eks_vpc" {
  value = aws_eks_cluster.eks_cluster

}

output "oidc" {
  value = module.eks_cluster.oidc_provider_arn
}

output "default_node_group_iam_role_arn" {
  description = "The ARN of the IAM role created for the default EKS Managed Node Group."
  value       = module.eks_cluster.eks_managed_node_groups["default"].iam_role_arn
}