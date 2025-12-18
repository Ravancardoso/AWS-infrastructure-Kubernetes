resource "aws_iam_policy" "eks_controller_policy" {
  name   = "EKS-projects-policy"
  policy = file("${path.module}/iam_policy.json")
  tags = merge(
    local.default_tags,
    local.environment_tags,
    {
      Name = "eks_controller_policy"
    }
  )
}