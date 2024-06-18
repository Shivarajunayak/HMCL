module "cloudfront" {
  source = "./aws-cloudfront"

  aliases                       = var.aliases
  comment                       = var.comment
  enabled                       = var.enabled
  is_ipv6_enabled               = var.is_ipv6_enabled
  price_class                   = var.price_class
  retain_on_delete              = var.retain_on_delete
  wait_for_deployment           = var.wait_for_deployment
  create_origin_access_identity = var.create_origin_access_identity
  origin_access_identities      = var.origin_access_identities
  logging_config                = var.logging_config
  origin                        = var.origin
  default_cache_behavior        = var.default_cache_behavior
  ordered_cache_behavior        = var.ordered_cache_behavior
  viewer_certificate            = var.viewer_certificate

  continuous_deployment_policy_id      = try(var.continuous_deployment_policy_id, null)
  default_root_object                  = try(var.default_root_object, null)
  http_version                         = try(var.http_version, null)
  web_acl_id                           = try(var.web_acl_id, null)
  staging                              = try(var.staging, false)
  origin_group                         = try(var.origin_group, null)
  geo_restriction                      = try(var.geo_restriction, null)
  custom_error_response                = try(var.custom_error_response, null)
  create_monitoring_subscription       = try(var.create_monitoring_subscription, false)
  realtime_metrics_subscription_status = try(var.realtime_metrics_subscription_status, "Enabled")
  tags                                 = try(var.tags, null)

}
