resource "harness_platform_connector_rancher" "container_registry" {
  count       = var.support_self_hosted ? 1 : 0
  identifier  = "buildfarm_container_registry"
  name        = "BuildFarm Container Registry"
  description = "BuildFarm Container Registry Connector"
  tags        = local.common_tags_tuple

  delegate_selectors = var.delegate_selectors
  rancher_url        = var.container_registry_url

  bearer_token {
    bearer_token_ref = var.container_registry_password
  }
}
