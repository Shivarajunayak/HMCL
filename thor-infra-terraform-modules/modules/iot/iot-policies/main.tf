
# policy
resource "aws_iot_policy" "iot_policies" {

  for_each = { for key, value in var.iot_policies : value.name => value }

  name   = each.value.name
  policy = each.value.policy
  tags   = var.tags

}
