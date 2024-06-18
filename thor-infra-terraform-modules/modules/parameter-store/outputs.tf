output "parameters_arn_map" {
  description = "parameter store ids map"
  value       = try({ for key, parameter in module.parameters : key => parameter.ssm_parameter_arn }, {})
}
