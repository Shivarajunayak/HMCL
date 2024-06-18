module "aws_cognito_user_pool_complete" {
  source = "./aws-cognito"

  user_pool_name           = try(var.user_pool_name, null)
  alias_attributes         = try(var.alias_attributes, null)
  auto_verified_attributes = try(var.auto_verified_attributes, null)

  deletion_protection = try(var.deletion_protection, null)

  sms_authentication_message = try(var.sms_authentication_message, null)
  sms_verification_message   = try(var.sms_verification_message, null)

  user_pool_add_ons_advanced_security_mode           = try(var.user_pool_add_ons_advanced_security_mode, null)
  verification_message_template_default_email_option = try(var.verification_message_template_default_email_option, null)

  admin_create_user_config = {
    email_subject = try(var.admin_create_user_config_email_subject, null)
    email_message = try(var.admin_create_user_config_email_message, null)
    sms_message   = try(var.admin_create_user_config_sms_message, null)
  }


  device_configuration = {
    challenge_required_on_new_device      = try(var.device_configuration_challenge_required_on_new_device, null)
    device_only_remembered_on_user_prompt = try(var.device_configuration_device_only_remembered_on_user_prompt, null)
  }

  email_configuration = {
    email_sending_account  = try(var.email_configuration_email_sending_account, null)
    reply_to_email_address = try(var.email_configuration_reply_to_email_address, null)
    source_arn             = try(var.email_configuration_source_arn, null)
  }

  password_policy = {
    minimum_length                   = try(var.password_policy_minimum_length, null)
    require_lowercase                = try(var.password_policy_require_lowercase, null)
    require_numbers                  = try(var.password_policy_require_numbers, null)
    require_symbols                  = try(var.password_policy_require_symbols, null)
    require_uppercase                = try(var.password_policy_require_uppercase, null)
    temporary_password_validity_days = try(var.password_policy_temporary_password_validity_days, null)
  }

  user_pool_add_ons = {
    advanced_security_mode = try(var.user_pool_add_ons_advanced_security_mode, null)
  }
  verification_message_template = {
    default_email_option = try(var.verification_message_template_default_email_option, null)
  }

  schemas        = try(var.schemas, null)
  string_schemas = try(var.string_schemas, null)
  number_schemas = try(var.number_schemas, null)

  recovery_mechanisms = try(var.recovery_mechanisms, null)

  domain = try(var.domain, null)

  client_name                                 = try(var.client_name, null)
  client_allowed_oauth_flows_user_pool_client = try(var.client_allowed_oauth_flows_user_pool_client, null)
  client_callback_urls                        = try(var.client_callback_urls, null)
  client_default_redirect_uri                 = try(var.client_default_redirect_uri, null)
  client_read_attributes                      = try(var.client_read_attributes, null)
  client_refresh_token_validity               = try(var.client_refresh_token_validity, null)

  lambda_config = {
    create_auth_challenge          = try(var.lambda_config_create_auth_challenge, null)
    custom_message                 = try(var.lambda_config_custom_message, null)
    define_auth_challenge          = try(var.lambda_config_define_auth_challenge, null)
    post_authentication            = try(var.lambda_config_post_authentication, null)
    post_confirmation              = try(var.lambda_config_post_confirmation, null)
    pre_authentication             = try(var.lambda_config_pre_authentication, null)
    pre_sign_up                    = try(var.lambda_config_pre_sign_up, null)
    pre_token_generation           = try(var.lambda_config_pre_token_generation, null)
    user_migration                 = try(var.lambda_config_user_migration, null)
    verify_auth_challenge_response = try(var.lambda_config_verify_auth_challenge_response, null)
    kms_key_id                     = try(var.lambda_config_kms_key_id, null)
    pre_token_generation_config    = try(var.lambda_config_pre_token_generation, null)
    custom_email_sender            = try(var.lambda_config_custom_email_sender, null)
    custom_sms_sender              = try(var.lambda_config_custom_sms_sender, null)
  }

  user_group_name        = try(var.user_group_name, null)
  user_group_description = try(var.user_group_description, null)
  user_group_precedence  = try(var.user_group_precedence, null)
  user_group_role_arn    = try(var.user_group_role_arn, null)

  resource_server_identifier        = try(var.resource_server_identifier, null)
  resource_server_name              = try(var.resource_server_name, null)
  resource_server_scope_name        = try(var.resource_server_scope_name, null)
  resource_server_scope_description = try(var.resource_server_scope_description, null)
  identity_providers                = try(var.identity_providers, null)

  tags = try(var.tags, null)

}
