resource "harness_platform_connector_nexus" "container_registry" {
  lifecycle {
    precondition {
      condition     = local.resource_self_hosted_ready == ""
      error_message = local.resource_self_hosted_ready
    }
  }
  count               = var.support_self_hosted ? 1 : 0
  identifier          = "buildfarm_container_registry_nexus"
  name                = "BuildFarm Container Registry nexux"
  description         = "BuildFarm Container Registry Connector"
  tags                = local.common_tags_tuple
  url                 = var.container_registry_url
  version             = var.nexus_version
  delegate_selectors  = var.delegate_selectors

  dynamic "credentials" {
    for_each = var.authentication_type_self_hosted == "UsernamePassword" ? [1] : []
    content {
      username     = var.container_registry_username
      password_ref = var.container_registry_password
    }
  }
}
