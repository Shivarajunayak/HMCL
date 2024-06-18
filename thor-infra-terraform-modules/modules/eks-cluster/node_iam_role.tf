resource "aws_iam_policy" "secret_access" {
  name = "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-secret-access-for-volumes-${random_string.random.result}"
  path = var.role_policy_path
  #REPLACE HERE
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_volumes_access" {
  name = "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-ec2volumes-access-${random_string.random.result}"
  path = "/"
  #REPLACE HERE
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateVolume",
          "ec2:CreateTags",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:DeleteVolume",
          "ec2:DeleteTags"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "eks_node_role" {

  #REPLACE HERE
  name = var.role_name_prefix == "" ? "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-EKS-node-role-${random_string.random.result}" : "hmcl-cv-${var.environment}-${lookup(local.regions, data.aws_region.current.name)}-${var.role_name_prefix}-EKS-node-role-${random_string.random.result}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_role_attachment" {
  for_each   = { for i, val in local.policies : i => val }
  role       = aws_iam_role.eks_node_role.name
  policy_arn = each.value
}
