variable "subordinate_ca_certificate_pem" {
    type = string
    default = ""
    description = "Subordinate CA Cert PEM"
}

variable "certificate_mode" {
    type = string
    default = ""
    description = "Certificate Mode"
}

variable "tags" {

  type    = any
  default = {}

}