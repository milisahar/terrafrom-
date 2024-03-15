resource "aws_iam_role" "preProd_role" {
  name = "eks-cluster-preProd_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "preProd_role-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.preProd_role.name
}

resource "aws_eks_cluster" "preProd" {
  name     = "preProd"
  role_arn = aws_iam_role.preProd_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-eu-west-1a.id,
      aws_subnet.private-eu-west-1b.id,
      aws_subnet.public-eu-west-1a.id,
      aws_subnet.public-eu-west-1b.id
    ]
    endpoint_public_access     = true
    endpoint_private_access    = true
    public_access_cidrs        = ["0.0.0.0/0"]
  }
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
  }
  depends_on = [aws_iam_role_policy_attachment.preProd_role-AmazonEKSClusterPolicy]
}

