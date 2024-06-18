variable "things" {
  description = "List of IoT things with their attribute keys, values, and tags"
  type = list(object({
    name            : string
    attribute_keys  : list(string)
    attribute_values: list(string)
    tags            : map(string)
  }))
}
variable "thing_groups" {
  description = "List of IoT thing groups with their attribute keys, values, description, and tags"
  type = list(object({
    name            : string
    parent_name     : string
    attribute_keys  : list(string)
    attribute_values: list(string)
    description     : string
    tags            : map(string)
  }))
}
