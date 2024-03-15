data "aws_caller_identity" "current" {
}
/*resource "aws_eks_access_entry" "access_entry_preProd" {
  cluster_name   = aws_eks_cluster.preProd.name
  principal_arn=data.aws_caller_identity.current.arn
}

resource "aws_eks_access_policy_association" "access_policy" {
  cluster_name = aws_eks_cluster.preProd.name
  principal_arn=data.aws_caller_identity.current.arn
  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  access_scope {
    type       = "cluster"
  }
}
output "principal_arn" {
  value = aws_eks_access_entry.access_entry_preProd.principal_arn
}*/
output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}