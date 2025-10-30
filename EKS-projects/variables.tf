variable "cidr_block" {
  type        = string
  description = "Network CIDR block te be used for the VPC"
}


variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS cluster used for the VPC property tag."
}

variable "project_name" {
  type        = string
  description = "project name to be used to name the resourses (Name tag)"

}

variable "common_tags" {
  type        = string
  description = "Mapa de tags comuns (environment, organization, project) recebidas do módulo raiz."
}