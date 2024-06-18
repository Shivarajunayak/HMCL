module "acm" {
  source = "./aws-acm"

  domain_name               = var.domain_name
  zone_id                   = var.zone_id
  validation_method         = var.validation_method
  subject_alternative_names = var.subject_alternative_names
  wait_for_validation       = var.wait_for_validation
  tags                      = var.tags

  create_certificate                          = try(var.create_certificate, true)
  create_route53_records_only                 = try(var.create_route53_records_only, false)
  validate_certificate                        = try(var.validate_certificate, true)
  validation_allow_overwrite_records          = try(var.validation_allow_overwrite_records, true)
  validation_timeout                          = try(var.validation_timeout, null)
  certificate_transparency_logging_preference = try(var.certificate_transparency_logging_preference, true)
  validation_option                           = try(var.validation_option, {})
  create_route53_records                      = try(var.create_route53_records, true)
  validation_record_fqdns                     = try(var.validation_record_fqdns, [])
  dns_ttl                                     = try(var.dns_ttl, 60)
  acm_certificate_domain_validation_options   = try(var.acm_certificate_domain_validation_options, {})
  distinct_domain_names                       = try(var.distinct_domain_names, [])
  key_algorithm                               = try(var.key_algorithm, null)
}
