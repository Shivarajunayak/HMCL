# Define IAM role for Kinesis Analytics
resource "aws_iam_role" "flink_role" {
  name = var.iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "kinesisanalytics.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = var.tags
}

# Create custom IAM policy for the role
resource "aws_iam_policy" "custom_policy" {
  name        = var.iam_policy_name
  description = "Custom policy for flink role"
  policy      = var.custom_policy_json
  tags = var.tags
}


# Attach policy to IAM role
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  role       = aws_iam_role.flink_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}