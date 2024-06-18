## azure agent ##
resource "kubectl_manifest" "azure_agent_namespace" {
  count     = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_namespace.yaml", {})
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_rbac" {
  count     = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_rbac.yaml", {})
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_configmap" {
  count     = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_configmap.yaml", {})
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_sa" {
  count = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_sa.yaml", {
    azure_agent_irsa_role_arn = try(var.azure_agent_configs.azure_agent_irsa_role_arn, "arn:aws:iam::637423293078:role/hmcl-cv-shared-aps1-azure-agent-irsa")
  })
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_spc" {
  count = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_spc.yaml", {
    azure_agent_aws_secret_name = try(var.azure_agent_configs.azure_agent_aws_secret_name, "hmcl-cv-azure-agent-secret")
  })
  depends_on = [
    module.eks_blueprints_addons
  ]
}


resource "kubectl_manifest" "azure_agent_kaniko_sa" {
  count = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_kaniko_sa.yaml", {
    azure_agent_kaniko_irsa_role_arn = try(var.azure_agent_configs.azure_agent_kaniko_irsa_role_arn, "arn:aws:iam::637423293078:role/hmcl-cv-shared-aps1-azure-agent-irsa")
  })
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_kaniko_configmap" {
  count = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_kaniko_configmap.yaml", {
    image_push_account_id = try(var.azure_agent_configs.image_push_account_id, "905418263290")
    image_push_region     = try(var.azure_agent_configs.image_push_region, "us-east-1")
  })
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_scaledjob_trigger_authentication" {
  count     = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_scaledjob_trigger_authentication.yaml", {})
  depends_on = [
    module.eks_blueprints_addons
  ]
}


resource "kubectl_manifest" "azure_agent_placeholder" {
  count = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_placeholder.yaml", {
    azure_agent_image_uri = try(var.azure_agent_configs.azure_agent_image_uri, "nginx:latest")
  })
  depends_on = [
    module.eks_blueprints_addons
  ]
}

resource "kubectl_manifest" "azure_agent_scaledjob" {
  count = var.register_as_spoke ? 0 : 1
  yaml_body = templatefile("${path.module}/configs/azure_agent_scaledjob.yaml", {
    azure_agent_image_uri         = try(var.azure_agent_configs.azure_agent_image_uri, "nginx:latest")
    azure_agent_replica_max_count = try(var.azure_agent_configs.azure_agent_replica_max_count, "100")
    azure_agent_pool_id           = try(var.azure_agent_configs.azure_agent_pool_id, "1")
  })
  depends_on = [
    module.eks_blueprints_addons
  ]
}



# resource "kubectl_manifest" "azure_agent_deployment" {
#   count = var.register_as_spoke ? 0 : 1
#   yaml_body = templatefile("${path.module}/configs/azure_agent_deployment.yaml", {
#     azure_agent_image_uri = try(var.azure_agent_configs.azure_agent_image_uri, "nginx:latest")
#   })
#   depends_on = [
#     module.eks_blueprints_addons
#   ]
# }
