resource "aws_iam_role" "role" {
  for_each = { for rule in var.iot_topic_rules : rule.rule_name => rule if rule.needs_iam }
  name               = each.key
  assume_role_policy = each.value.assume_role_policy_action
  tags               = try(each.value.tags, {})
}
resource "aws_iam_policy" "custom_policies" {
  for_each = { for rule in var.iot_topic_rules : rule.rule_name => rule if rule.needs_iam }
  name        = "${each.key}_policy"
  description = "Custom policy for ${each.key}"
  policy      = each.value.custom_policy_action
  tags        = try(each.value.tags, {})
}
resource "aws_iam_role_policy_attachment" "policy_attachments" {
  for_each = { for rule in var.iot_topic_rules : rule.rule_name => rule if rule.needs_iam }
  role       = aws_iam_role.role[each.key].name
  policy_arn = aws_iam_policy.custom_policies[each.key].arn
}

resource "aws_cloudwatch_log_group" "kafka_error_logs" {
  for_each = { for rule in var.iot_topic_rules : rule.rule_name => rule if rule.error_action != null && lookup(rule.error_action, "kafka", null) != null }
  name              = "/aws/kafka/errors/${each.value.rule_name}"
  retention_in_days = try(each.value.retention_in_days, 7)
  tags              = try(each.value.tags, {})
}

resource "aws_iot_topic_rule" "topic_rule" {
  for_each = { for rule in var.iot_topic_rules : rule.rule_name => rule }
  name        = each.value.rule_name
  sql         = each.value.sql
  sql_version = each.value.sql_version
  description = each.value.description
  tags        = try(each.value.tags, {})
  enabled     = true
  dynamic "lambda" {
    for_each = each.value.action.lambda != null ? [each.value.action.lambda] : []
    content {
      function_arn = lambda.value.function_arn
    }
  }
  dynamic "dynamodb" {
    for_each = each.value.action.dynamodb != null ? [each.value.action.dynamodb] : []
    content {
      table_name      = dynamodb.value.table_name
      role_arn        = "${aws_iam_role.role[each.key].arn}"
      hash_key_field  = try(dynamodb.value.hash_key_field, null)
      hash_key_value  = try(dynamodb.value.hash_key_value, null)
    }
  }
  dynamic "kafka" {
    for_each = each.value.action.kafka != null ? [each.value.action.kafka] : []
    content {
      destination_arn   = kafka.value.destination_arn
      topic             = kafka.value.topic
      key               = kafka.value.key
      client_properties = {
        "bootstrap.servers"  = kafka.value.client_properties.bootstrap_servers
        "security.protocol"  = kafka.value.client_properties.security_protocol
        "sasl.mechanism"     = kafka.value.client_properties.sasl_mechanism
        "sasl.scram.username" = "$${get_secret('${kafka.value.client_properties.sasl_secret_name}', 'SecretString', 'username', '${aws_iam_role.role[each.key].arn}')}"
        "sasl.scram.password" = "$${get_secret('${kafka.value.client_properties.sasl_secret_name}', 'SecretString', 'password', '${aws_iam_role.role[each.key].arn}')}"
        "compression.type"    = kafka.value.client_properties.compression_type
        "acks"               = kafka.value.client_properties.acks
      }
    }
  }
  dynamic "republish" {
    for_each = each.value.action.republish != null ? [each.value.action.republish] : []
    content {
      role_arn = "${aws_iam_role.role[each.key].arn}"
      topic    = republish.value.topic
      qos      = republish.value.qos
    }
  }
  dynamic "error_action" {
    for_each = each.value.error_action != null ? [each.value.error_action] : []
    content {
      dynamic "dynamodb" {
        for_each = error_action.value.dynamodb != null ? [error_action.value.dynamodb] : []
        content {
          table_name     = dynamodb.value.table_name
          role_arn       = "${aws_iam_role.role[each.key].arn}"
          hash_key_field = try(dynamodb.value.hash_key_field, null)
          hash_key_value = try(dynamodb.value.hash_key_value, null)
        }
      }

      dynamic "kafka" {
        for_each = error_action.value.kafka != null ? [error_action.value.kafka] : []
        content {
          destination_arn   = kafka.value.destination_arn
          topic             = kafka.value.topic
          key               = kafka.value.key
          client_properties = {
            "bootstrap.servers"   = kafka.value.client_properties.bootstrap_servers
            "security.protocol"   = kafka.value.client_properties.security_protocol
            "sasl.mechanism"      = kafka.value.client_properties.sasl_mechanism
            "sasl.scram.username" = "$${get_secret('${kafka.value.client_properties.sasl_secret_name}', 'SecretString', 'username', '${aws_iam_role.role[each.key].arn}')}"
            "sasl.scram.password" = "$${get_secret('${kafka.value.client_properties.sasl_secret_name}', 'SecretString', 'password', '${aws_iam_role.role[each.key].arn}')}"
            "compression.type"    = kafka.value.client_properties.compression_type
            "acks"                = kafka.value.client_properties.acks
          }
        }
      }

      dynamic "lambda" {
        for_each = error_action.value.lambda != null ? [error_action.value.lambda] : []
        content {
          function_arn = lambda.value.function_arn
        }
      }

      dynamic "cloudwatch_logs" {
        for_each = error_action.value.cloudwatch_logs != null ? [error_action.value.cloudwatch_logs] : []
        content {
          log_group_name = cloudwatch_logs.value.log_group_name
          role_arn       = "${aws_iam_role.role[each.key].arn}"
        }
      }

      dynamic "republish" {
        for_each = error_action.value.republish != null ? [error_action.value.republish] : []
        content {
          role_arn = "${aws_iam_role.role[each.key].arn}"
          topic    = republish.value.topic
          qos      = republish.value.qos
        }
      }
    }
  }
}
