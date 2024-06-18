locals {
parsed_json = jsondecode(var.decoder_manifest_json)
}

resource "local_file" "output_decoder_manifest_json" {
content  = jsonencode(local.parsed_json)
filename = "${path.module}/decoder_manifest_configuration.json"
}


resource "null_resource" "decoder_manifest" {

depends_on = [local_file.output_decoder_manifest_json]

triggers = {
decoder_manifest_json = sha256(jsonencode(local.parsed_json))
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
aws iotfleetwise --endpoint-url ${var.fleetwise_endpoint_url} create-decoder-manifest  --cli-input-json file://${path.module}/decoder_manifest_configuration.json --region ${var.aws_region}
EOF
}
}