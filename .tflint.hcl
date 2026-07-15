# Retained compatibility declarations are tracked separately from lint tooling.
rule "terraform_unused_declarations" {
  enabled = false
}

# Collection behavior changes require focused tests and a separate review.
rule "terraform_empty_list_equality" {
  enabled = false
}
