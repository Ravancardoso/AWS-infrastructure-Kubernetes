# Obtém o certificado TLS do OIDC Provider do EKS

data "tls_certificate" "eks_oidc_tls_certificate" {
  url = module.eks_cluster.cluster_oidc_issuer_url
}

#provedor OIDC

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks_oidc_tls_certificate.certificates[0].sha1_fingerprint]
  url             = module.eks_cluster.cluster_oidc_issuer_url
}