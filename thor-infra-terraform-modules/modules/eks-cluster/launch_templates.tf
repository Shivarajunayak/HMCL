resource "aws_launch_template" "custom_launch_template" {
  name = "${module.eks.cluster_name}-${var.environment}-eks-custom-lt"
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.launch_template_volume_size
    }
  }
  user_data = filebase64("${path.module}/configs/custom_userdata.tmpl")
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }
}
