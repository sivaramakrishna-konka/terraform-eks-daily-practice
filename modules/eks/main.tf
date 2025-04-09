##################################################################################
# IAM Role for EKS Cluster
##################################################################################
resource "aws_iam_role" "cluster" {
  name = "${var.environment}-${var.project_name}-cluster-role"
  # The role that the EKS cluster will assume
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "control_plane_policy"{
   for_each = toset([
      "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
   ])
   policy_arn = each.value
   role = aws_iam_role.cluster.name
}

###################################################################################
# IAM Role for EKS Node Group
###################################################################################
resource "aws_iam_role" "node_group" {
  name = "${var.environment}-${var.project_name}-node-group"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_group_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    "arn:aws:iam::522814728660:policy/AllowExternalDNSUpdates",
    "arn:aws:iam::522814728660:policy/AWSLoadBalancerControllerIAMPolicy"
  ])

  policy_arn = each.value
  role       = aws_iam_role.node_group.name
}

###################################################################################
# EKS Cluster
###################################################################################
resource "aws_eks_cluster" "example" {
  name = "${var.environment}-${var.project_name}"
  role_arn = aws_iam_role.cluster.arn
  version  = var.eks_version
  enabled_cluster_log_types = ["api","audit","authenticator","controllerManager","scheduler"] ]

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }



  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids = var.security_group_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.control_plane_policy
  ]
}
