resource "aws_iot_ca_certificate" "iot_ca_certificate" {
    active                       = true
    ca_certificate_pem           = var.subordinate_ca_certificate_pem
    allow_auto_registration      = true
    certificate_mode = var.certificate_mode
    tags = var.tags
}