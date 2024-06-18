locals {
  fleet_config = {
    fleet_id           = var.fleet_id
    description        = var.fleet_description
    signal_catalog_arn = var.signal_catalog_arn
  }
}

resource "null_resource" "create_fleet" {
  
  triggers = {
    fleet_config_json = sha256(jsonencode(local.fleet_config))
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
aws iotfleetwise --endpoint-url ${var.fleetwise_endpoint_url} list-fleets --region ${var.aws_region}
aws iotfleetwise --endpoint-url ${var.fleetwise_endpoint_url} create-fleet --fleet-id ${var.fleet_id} --description "${var.fleet_description}" --signal-catalog-arn ${var.signal_catalog_arn} --region ${var.aws_region}
EOF
  }
}