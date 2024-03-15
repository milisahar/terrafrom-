resource "aws_iam_role" "preProd_nodes" {
  name = "eks-cluster-preProd-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
	}

resource "aws_iam_role_policy_attachment" "preProd_nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.preProd_nodes.name
}

resource "aws_iam_role_policy_attachment" "preProd_nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.preProd_nodes.name
}

resource "aws_iam_role_policy_attachment" "preProd_nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.preProd_nodes.name
}
resource "aws_iam_role_policy_attachment" "preProd_nodes-ElasticLoadBalancingFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  role       = aws_iam_role.preProd_nodes.name
}
resource "aws_iam_role_policy_attachment" "preProd_nodes-AmazonS3FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.preProd_nodes.name
}

resource "aws_eks_node_group" "preProd-private-nodes" {
  cluster_name    = aws_eks_cluster.preProd.name
  node_group_name = "preProd-private-nodes"
  node_role_arn   = aws_iam_role.preProd_nodes.arn

  subnet_ids = [
    aws_subnet.private-eu-west-1a.id,
    aws_subnet.private-eu-west-1b.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["m7a.large"]

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.preProd_nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.preProd_nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.preProd_nodes-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.preProd_nodes-ElasticLoadBalancingFullAccess,
    aws_iam_role_policy_attachment.preProd_nodes-AmazonS3FullAccess,
  ]
}
