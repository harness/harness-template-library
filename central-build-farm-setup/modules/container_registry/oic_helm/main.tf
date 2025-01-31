resource "harness_platform_connector_oci_helm" "container_registry" {
  lifecycle {
    precondition {
      condition     = local.resource_self_hosted_ready == ""
      error_message = local.resource_self_hosted_ready
    }
  }
  count              = var.support_self_hosted ? 1 : 0
  identifier         = "buildfarm_container_registry"
  name               = "BuildFarm Container Registry"
  description        = "BuildFarm Container Registry Connector"
  tags               = local.common_tags_tuple
  url                = var.container_registry_url
  delegate_selectors = var.delegate_selectors

  dynamic "credentials" {
    for_each = var.auth_type == "UsernamePassword" ? [1] : []
    content {
      username     = var.container_registry_username
      password_ref = var.container_registry_password
    }
  }
}