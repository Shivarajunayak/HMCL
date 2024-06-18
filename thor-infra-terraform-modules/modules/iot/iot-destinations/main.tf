# IAM Role
resource "aws_iam_role" "example" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  tags = var.tags
}
# Create custom IAM policy for the role
resource "aws_iam_policy" "custom_policy" {
  name        = var.iam_policy_name
  description = "Custom policy for IoT destinations"
  policy      = var.iot_destinations_custom_policy_json
  tags = var.tags
}
# Attach policy to IAM role
resource "aws_iam_role_policy_attachment" "custom_policy_attachment" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.custom_policy.arn
}
# IoT Topic Rule Destination
resource "aws_iot_topic_rule_destination" "example" {
  vpc_configuration {
    role_arn        = aws_iam_role.example.arn
    security_groups = [var.security_group_id]
    subnet_ids      = var.subnet_ids
    vpc_id          = var.vpc_id
  }
}
