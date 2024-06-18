# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.

include "root" {
  path = find_in_parent_folders()
}


# Configure the version of the module to use in this environment. This allows you to promote new versions one
# environment at a time (e.g., qa -> stage -> prod).

terraform {
  source = "git@ssh.dev.azure.com:v3/hero-ev-team/CVPI%20-%20Thor%20Infra%20DevOps/thor-infra-terraform-modules//modules/eks-cluster"
}

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Automatically load irsa yaml
  irsa = yamldecode(file("${get_terragrunt_dir()}/configs/irsa.yaml"))


  # Extract the variables we need for easy access

  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_account_name = local.account_vars.locals.account_name
  aws_region       = local.region_vars.locals.aws_region
  aws_region_short = local.region_vars.locals.aws_region_short
  sso_region       = local.region_vars.locals.sso_region
  deployment_role  = local.account_vars.locals.deployment_role
  environment      = local.environment_vars.locals.environment
}


# Inputs to the source Terraform module

inputs = {

  cluster_name                   = "hmcl-cv-dev-app-cluster"
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true

  # Enable AWS Managed addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
    adot = {
      most_recent = true
    }
  }

  vpc_id                   = "vpc-0816899ffeac2813d"                                  //dependency.vpc.outputs.vpc_id
  subnet_ids               = ["subnet-0817c01b2248ce1a9", "subnet-0e999c0ab8960634e"] //dependency.vpc.outputs.private_subnets
  control_plane_subnet_ids = ["subnet-0817c01b2248ce1a9", "subnet-0e999c0ab8960634e"] //dependency.vpc.outputs.private_subnets

  cluster_security_group_additional_rules = {
    inress_shared_services_vpc = {
      description                   = "Access EKS from Shared VPC."
      protocol                      = "tcp"
      from_port                     = 443
      to_port                       = 443
      type                          = "ingress"
      cidr_blocks                   = ["10.62.224.0/19"]
      source_cluster_security_group = true
    }
  }

  create_kms_key = false
  cluster_encryption_config = {

    provider_key_arn = dependency.kms.outputs.key_arn
    resources        = ["secrets"]

  }


  irsa_configs = local.irsa.roles
  environment  = "${local.environment}"


  eks_managed_node_group_defaults = {
    instance_types = ["m5a.xlarge", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {

    hmcl-cvp-dev-app-ng = {
      name          = "shared"
      min_size      = 0
      max_size      = 10
      desired_size  = 2
      capacity_type = "ON_DEMAND"
      labels = {
        shared = "true"
      }
      instance_types = ["m5a.xlarge"]
    }

  }

  # Enable/Disbale addons, other than the AWS managed ones

  enable_aws_efs_csi_driver                    = false
  enable_aws_fsx_csi_driver                    = false
  enable_argocd                                = false
  enable_argo_rollouts                         = false
  enable_argo_workflows                        = false
  enable_aws_cloudwatch_metrics                = true
  enable_aws_privateca_issuer                  = false
  enable_cert_manager                          = true
  enable_cluster_autoscaler                    = false
  enable_secrets_store_csi_driver              = true
  enable_secrets_store_csi_driver_provider_aws = true
  enable_kube_prometheus_stack                 = true
  enable_external_dns                          = true
  enable_external_secrets                      = false
  enable_gatekeeper                            = false
  enable_aws_load_balancer_controller          = true
  manage_aws_auth_configmap                    = true
  enable_karpenter                             = true
  enable_metrics_server                        = true
  enable_aws_for_fluentbit                     = true

  aws_for_fluentbit_cw_log_group = {
    create          = true
    use_name_prefix = false # Set this to true to enable name prefix
    name_prefix     = "eks-cluster-logs-"
    retention       = 14
  }



  aws_auth_roles = []
  aws_auth_users = []

  enable_cluster_creator_admin_permissions = true
  access_entries = {

    poweruser = {
      principal_arn = "arn:aws:iam::${local.aws_account_id}:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_PowerUserAccess_d1a438fc845c472d"
      policy_associations = {
        policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    admin = {
      principal_arn = "arn:aws:iam::${local.aws_account_id}:role/aws-reserved/sso.amazonaws.com/${local.sso_region}/AWSReservedSSO_AdministratorAccess_7bfca4206085685b"
      policy_associations = {
        policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    argocd_controller = {
      principal_arn = "arn:aws:iam::${local.aws_account_id}:role/hmcl-cv-${local.environment}-app-cluster-${local.aws_region_short}-argocd-spoke-role"
      policy_associations = {
        policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    cloud9_role = {
      principal_arn = "arn:aws:iam::${local.aws_account_id}:role/service-role/AWSCloud9SSMAccessRole"
      policy_associations = {
        policy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }


  karpenter_configs = {

    cpu_limit                   = "2000"
    memory_limit                = "2000Gi"
    instance_types              = ["m5a.xlarge", "m5.large", "m5n.large", "m5zn.large"]
    capacity_type               = ["on-demand"]
    consolidation               = true
    karpenter_shared_subnet_tag = "*shared*"
    karpenter_back_subnet_tag   = "*back*"
    labels = {
      intent = "apps"
    }

  }


  register_as_spoke = true
  management_cluster_state = {

    bucket   = "hmcl-cv-sharedtenant-thor-terragrunt-statefile-bucket"
    key      = "devops-account/ap-south-1/shared/eks-cluster/terraform.tfstate"
    role_arn = "arn:aws:iam::637423293078:role/hmcl-terraform-assume-role"

  }


  argocd_controller_role_arn = [

    "arn:aws:iam::637423293078:role/hmcl-cv-shared-aps1-argo-irsa"

  ]


  tags = {
    Owner               = "dev-team"
    project-name        = "connected-vehicle-platform"
    Name                = "hmcl-cv-${local.environment}-app-eks"
    resource-type       = "cloudfront"
    resource-layer      = "apps"
    account-name        = "${local.aws_account_name}"
    region              = "${local.aws_region}"
    env                 = "${local.environment}"
    account-number      = "${local.aws_account_id}"
    project-id          = "1"
    bu-criticality      = "low"
    data-classification = "internal"
    Terraform           = true
  }


}







# dependency "vpc" {
#  config_path = "../vpc"
# }


dependency "kms" {
  config_path = "../../kms"
  mock_outputs = {
    key_arn = "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}