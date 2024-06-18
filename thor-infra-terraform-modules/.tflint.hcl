config {
    format = "compact"
    disabled_by_default = true
}

plugin "aws" {
  enabled = true
  version = "0.23.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "terraform" {
  enabled = true
  version = "0.3.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}


rule "terraform_comment_syntax" {
    enabled = true
}

rule "terraform_documented_outputs" {
    enabled = true
}

rule "terraform_documented_variables" {
    enabled = false
}

rule "terraform_typed_variables" {
    enabled = false
}


rule "terraform_module_pinned_source" {
    enabled = true
}

rule "terraform_naming_convention" {
    enabled = true
    format = "snake_case"
}
