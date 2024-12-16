locals {
  base_domain = data.terraform_remote_state.remote_states.outputs.base_domain
  environment = data.terraform_remote_state.remote_states.outputs.environment
  renterd_base_domain = format("node.%s", local.base_domain)
  placement_attributes = {
    "lumeweb" = true
  }
}
