locals {
  required_tags = {
    required_for : "buildfarm_container_registry"
  }

  common_tags = merge(
    var.tags,
    local.required_tags
  )

  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  delegate_selector_ready = (
    var.support_self_hosted
    ?
    var.delegate_selectors == []
    ?
    "[Invalid] Missing value for 'delegate_selectors', required for self-hosted connectors."
    :
    null
    :
    null
  )

  rancher_url_valid = (
    length(var.container_registry_url) > 0
    ? null
    : "[Invalid] Missing value for 'k8s_rancher_url', required for Rancher connector."
  )

  bearer_token_ready = (
    var.container_registry_password == null
    ? "[Invalid] Missing value for 'k8s_bearer_token_ref', required for Rancher connector."
    : null
  )

  self_hosted_verification_message = compact([
    local.delegate_selector_ready,
    local.rancher_url_valid,
    local.bearer_token_ready
  ])

  resource_self_hosted_ready = (
    var.support_self_hosted && length(local.self_hosted_verification_message) > 0
    ? join("\n", local.self_hosted_verification_message)
    : ""
  )
}
