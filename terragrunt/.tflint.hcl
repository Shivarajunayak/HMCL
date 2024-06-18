config {
  module = true
}

// Plugin configuration
plugin "aws" {
  enabled = true
  version = "0.29.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
  version = "0.4.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}