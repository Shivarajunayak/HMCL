locals {
  lks_template_config = {
    signal_catalog_arn       = var.signal_catalog_arn
    lks_template_name        = var.lks_template_name
    state_template_properties = var.state_template_properties
  }
}
resource "null_resource" "create_lks_template" {
  triggers = {
    lks_template_config_json = sha256(jsonencode(local.lks_template_config))
  }
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<EOF
CREDENTIALS=(`aws sts assume-role \
  --role-arn ${var.terraform_role_arn} \
  --role-session-name "spoke-account-role" \
  --query "[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]" \
  --output text`)
unset AWS_PROFILE
export AWS_DEFAULT_REGION=${var.aws_region}
export AWS_ACCESS_KEY_ID="$${CREDENTIALS[0]}"
export AWS_SECRET_ACCESS_KEY="$${CREDENTIALS[1]}"
export AWS_SESSION_TOKEN="$${CREDENTIALS[2]}"
aws sts get-caller-identity
aws iotfleetwise --endpoint-url ${var.fleetwise_endpoint_url} create-state-template --name ${var.lks_template_name} \
  --region ${var.aws_region} \
  --signal-catalog-arn ${SIGNAL_CATALOG_ARN} \
  --state-template-properties '["${join("\", \"", var.state_template_properties)}"]'
EOF
  }
}