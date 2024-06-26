module "emr" {
  source                                 = "./aws-emr"
  name                                   = var.name
  release_label                          = var.release_label
  applications                           = var.applications
  auto_termination_policy                = var.auto_termination_policy
  bootstrap_action                       = var.bootstrap_action
  create_security_configuration          = var.create_security_configuration
  security_configuration                 = var.security_configuration
  security_configuration_name            = var.security_configuration_name
  security_configuration_use_name_prefix = var.security_configuration_use_name_prefix
  configurations_json                    = var.configurations_json
  master_instance_fleet                  = var.master_instance_fleet
  core_instance_fleet                    = var.core_instance_fleet
  task_instance_fleet                    = var.task_instance_fleet
  ebs_root_volume_size                   = var.ebs_root_volume_size
  ec2_attributes                         = var.ec2_attributes
  vpc_id                                 = var.vpc_id
  list_steps_states                      = var.list_steps_states
  log_uri                                = var.log_uri
  scale_down_behavior                    = var.scale_down_behavior
  step_concurrency_level                 = var.step_concurrency_level
  termination_protection                 = var.termination_protection
  visible_to_all_users                   = var.visible_to_all_users
  tags                                   = var.tags
}
