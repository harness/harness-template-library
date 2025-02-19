
resource "harness_platform_connector_docker" "container_registry" {
  count       = var.support_self_hosted ? 1 : 0
  identifier  = "buildfarm_container_registry"
  name        = "BuildFarm Container Registry"
  description = "BuildFarm Container Registry Connector"
  tags        = local.common_tags_tuple

  type                = var.provider_type
  url                 = var.container_registry_url
  delegate_selectors  = var.delegate_selectors
  execute_on_delegate = true
  credentials {
    username_ref = var.container_registry_username
    password_ref = var.container_registry_password
  }
}

resource "harness_platform_connector_docker" "container_registry_cloud" {
  count       = var.support_harness_cloud ? 1 : 0
  identifier  = "buildfarm_container_registry_cloud"
  name        = "BuildFarm Container Registry - Cloud"
  description = "BuildFarm Container Registry Connector for Harness CI Cloud builds"
  tags        = local.common_tags_tuple

  type                = var.provider_type
  url                 = var.container_registry_url
  execute_on_delegate = false
  credentials {
    username_ref = var.container_registry_username
    password_ref = var.container_registry_password
  }
}
