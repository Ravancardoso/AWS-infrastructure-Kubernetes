variable "cidr_block" {
  type        = string
  description = "Network CIDR block te be used for the VPC"
  default     = "10.0.0.0/16"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster used for the VPC property tag."
  default     = "cluster-eks-lab-dev"
}

variable "project_name" {
  type        = string
  description = "project name to be used to name the resourses (Name tag)"
  default     = "EKS-Project"
}