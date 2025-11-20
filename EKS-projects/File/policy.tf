resource "aws_iam_policy" "eks_controller_policy" {
  name   = "EKS-projects-policy"
  policy = file("${path.module}/iam_policy.json")
  tags = {
    Name        = "EKS-project-policy"
    environment = "development"
  }
}