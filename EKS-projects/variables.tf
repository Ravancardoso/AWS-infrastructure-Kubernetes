variable "cidr_block" {
  type        = string
  description = "Network CIDR block te be used for the VPC"
}


variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster used for the VPC property tag."
}