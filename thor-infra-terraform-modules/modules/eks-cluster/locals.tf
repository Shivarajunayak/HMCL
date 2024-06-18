# Istion Addon Locals
locals {

  regions = {
    "ap-south-1"     = "aps1",
    "eu-west-2"      = "eu2",
    "eu-west-1"      = "eu1",
    "ap-southeast-1" = "ap1",
    "us-east-1"      = "use1",
    "us-west-2"      = "usw2"
  }


  istio_chart_url     = "https://istio-release.storage.googleapis.com/charts"
  istio_chart_version = "1.18.1"

  policies = [
    aws_iam_policy.secret_access.arn,
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    aws_iam_policy.ec2_volumes_access.arn
  ]

  managed_node_group_configs = {
    for key, config in var.eks_managed_node_groups :
    "${key}" => {
      min_size                   = config.min_size
      max_size                   = config.max_size
      desired_size               = config.desired_size
      instance_types             = config.instance_types
      capacity_type              = config.capacity_type
      labels                     = config.labels
      use_custom_launch_template = true
      create_launch_template     = false
      launch_template_id         = try(config.launch_template_id, aws_launch_template.custom_launch_template.id)
      launch_template_version    = try(config.launch_template_version, 1)
      create_iam_role            = false
      iam_role_arn               = aws_iam_role.eks_node_role.arn
      ami_type                   = try(config.ami_type, null)
      taints                     = try(config.taints, {})
    }
  }

  mgmt_cluster = {
    cluster_endpoint = var.register_as_spoke ? try(data.terraform_remote_state.mgmt_cluster[0].outputs.cluster_endpoint, module.eks.cluster_endpoint) : module.eks.cluster_endpoint

    cluster_ca_certificate = var.register_as_spoke ? try(data.terraform_remote_state.mgmt_cluster[0].outputs.cluster_certificate_authority_data, module.eks.cluster_certificate_authority_data) : module.eks.cluster_certificate_authority_data

    cluster_name = var.register_as_spoke ? try(data.terraform_remote_state.mgmt_cluster[0].outputs.cluster_name, module.eks.cluster_name) : module.eks.cluster_name

    role_arn = var.register_as_spoke ? var.management_cluster_state.role_arn : var.assume_role
  }

  # normal_cluster = {
  #   cluster_endpoint =  module.eks.cluster_endpoint

  #   cluster_ca_certificate = module.eks.cluster_certificate_authority_data

  #   cluster_name = module.eks.cluster_name

  #   role_arn = var.assume_role
  # }
}
