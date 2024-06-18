variable "root_ca_common_name" {
  description = "Common name for the Root CA."
  type        = string
  default     = "example.com"
}
variable "subordinate_ca_common_name" {
  description = "Common name for the Subordinate CA."
  type        = string
  default     = "sub.example.com"
}
variable "root_ca_key_algorithm" {
  description = "Key algorithm for the Root CA."
  type        = string
  default     = "RSA_4096"
}
variable "root_ca_signing_algorithm" {
  description = "Signing algorithm for the Root CA."
  type        = string
  default     = "SHA512WITHRSA"
}
variable "subordinate_ca_key_algorithm" {
  description = "Key algorithm for the Subordinate CA."
  type        = string
  default     = "RSA_2048"
}
variable "subordinate_ca_signing_algorithm" {
  description = "Signing algorithm for the Subordinate CA."
  type        = string
  default     = "SHA512WITHRSA"
}
variable "root_ca_validity_years" {
  description = "Validity period in years for the Root CA certificate."
  type        = number
  default     = 10
}
variable "subordinate_ca_validity_years" {
  description = "Validity period in years for the Subordinate CA certificate."
  type        = number
  default     = 5
}
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {
    Environment = "production"
    Project     = "ACM PCA"
  }
}