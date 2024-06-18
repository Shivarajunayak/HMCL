

module "lambda_function_existing_package_s3" {
  source = "./aws-lambda"

  create                     = try(var.create, false)
  create_package             = try(var.create_package, false)
  s3_existing_package        = try(var.s3_existing_package, null)
  create_lambda_function_url = try(var.create_lambda_function_url, false)
  architectures              = try(var.architectures, ["x86_64"])
  function_name              = try(var.function_name, "test-function")
  description                = try(var.description, "test-function")
  handler                    = try(var.handler, "index.lambda_handler")
  runtime                    = try(var.runtime, "python3.9")
  layers                     = try(var.layers, [])
  publish                    = try(var.publish, false)

  timeout                = try(var.timeout, 300)
  memory_size            = try(var.memory_size, 128)
  ephemeral_storage_size = try(var.ephemeral_storage_size, 512)

  kms_key_arn = try(var.kms_key_arn, null)

  event_source_mapping  = try(var.event_source_mapping, {})
  allowed_triggers      = try(var.allowed_triggers, {})
  environment_variables = try(var.environment_variables, {})

  role_name                     = try(var.role_name, null)
  role_force_detach_policies    = try(var.role_force_detach_policies, true)
  assume_role_policy_statements = try(var.assume_role_policy_statements, {})
  attach_policies               = try(var.attach_policies, false)
  attach_policy_jsons           = try(var.attach_policy_jsons, false)
  attach_policy_statements      = try(var.attach_policy_statements, false)
  number_of_policies            = try(var.number_of_policies, 0)
  number_of_policy_jsons        = try(var.number_of_policy_jsons, 0)

  policies          = try(var.policies, [])
  policy_jsons      = try(var.policy_jsons, [])
  policy_statements = try(var.policy_statements, {})

  trusted_entities          = try(var.trusted_entities, [])
  attach_network_policy     = try(var.attach_network_policy, true)
  attach_tracing_policy     = try(var.attach_tracing_policy, true)
  attach_dead_letter_policy = try(var.attach_dead_letter_policy, true)
  attach_async_event_policy = try(var.attach_async_event_policy, true)
  vpc_security_group_ids    = try(var.vpc_security_group_ids, [])
  vpc_subnet_ids            = try(var.vpc_subnet_ids, [])

  attach_cloudwatch_logs_policy     = try(var.attach_cloudwatch_logs_policy, true)
  cloudwatch_logs_retention_in_days = try(var.cloudwatch_logs_retention_in_days, null)
  cloudwatch_logs_kms_key_id        = try(var.cloudwatch_logs_kms_key_id, null)


  cloudwatch_logs_tags = var.tags
  role_tags            = var.tags
  tags                 = var.tags
}
