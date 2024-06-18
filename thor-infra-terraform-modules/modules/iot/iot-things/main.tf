# Create IoT things dynamically
resource "aws_iot_thing" "this" {
  for_each   = { for thing in var.things : thing.name => thing }
  name       = each.value.name
  attributes = zipmap(each.value.attribute_keys, each.value.attribute_values)
}
# Create IoT thing groups dynamically
resource "aws_iot_thing_group" "this" {
  for_each = { for group in var.thing_groups : group.name => group }
  name = each.value.name
  parent_group_name = each.value.parent_name != "" ? each.value.parent_name : null
  properties {
    attribute_payload {
      attributes = zipmap(each.value.attribute_keys, each.value.attribute_values)
    }
    description = each.value.description
  }
  tags = each.value.tags
}
# Link things to their groups dynamically
resource "aws_iot_thing_group_membership" "this" {
  for_each = { for thing in var.things : thing.name => thing }
  thing_name       = each.value.name
  thing_group_name = try(aws_iot_thing_group.this[each.value.name].name, "")
}
