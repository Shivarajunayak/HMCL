locals {
parsed_json = jsondecode(var.signal_catalog_json)
}

resource "local_file" "output_signal_catalog_json" {
content  = jsonencode(local.parsed_json)
filename = "${path.module}/signal_catalog_configuration.json"
}


resource "null_resource" "signal_catalog" {

depends_on = [local_file.output_signal_catalog_json]

triggers = {
signal_catalog_json = sha256(jsonencode(local.parsed_json))
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
aws iotfleetwise --endpoint-url ${var.fleetwise_endpoint_url} list-signal-catalogs --region ${var.aws_region}
aws iotfleetwise --endpoint-url ${var.fleetwise_endpoint_url} create-signal-catalog --name ${var.signal_catalog_name} --cli-input-json file://${path.module}/signal_catalog_configuration.json --region ${var.aws_region}
EOF
}
}