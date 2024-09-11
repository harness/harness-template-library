resource "harness_platform_secret_text" "container_registry_username" {
  identifier  = "buildfarm_container_registry_username"
  name        = "BuildFarm Container Registry Username"
  description = "Username used by BuildFarm Container Registry Connector"
  tags = flatten([
    ["required_for:buildfarm_container_registry"],
    local.common_tags_tuple
  ])

  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = "changeme"
}

resource "harness_platform_secret_text" "container_registry_password" {
  identifier  = "buildfarm_container_registry_password"
  name        = "BuildFarm Container Registry Password"
  description = "Password used by BuildFarm Container Registry Connector"
  tags = flatten([
    ["required_for:buildfarm_container_registry"],
    local.common_tags_tuple
  ])

  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = "changeme"
}

resource "harness_platform_connector_docker" "container_registry" {
  count       = local.container_registry_type == "docker" ? 1 : 0
  identifier  = "buildfarm_container_registry"
  name        = "BuildFarm Container Registry"
  description = "BuildFarm Container Rgistry Connector"
  tags = flatten([
    ["required_for:buildfarm_container_registry"],
    local.common_tags_tuple
  ])

  type                = "DockerHub"
  url                 = var.container_registry_url
  delegate_selectors  = local.delegate_selectors
  execute_on_delegate = var.use_self_hosted
  credentials {
    username_ref = "account.${harness_platform_secret_text.container_registry_username.id}"
    password_ref = "account.${harness_platform_secret_text.container_registry_password.id}"
  }
}

resource "harness_platform_connector_artifactory" "container_registry" {
  count       = local.container_registry_type == "artifactory" ? 1 : 0
  identifier  = "buildfarm_container_registry"
  name        = "BuildFarm Container Registry"
  description = "BuildFarm Container Rgistry Connector"
  tags = flatten([
    ["required_for:buildfarm_container_registry"],
    local.common_tags_tuple
  ])

  url                = var.container_registry_url
  delegate_selectors = local.delegate_selectors
  credentials {
    username_ref = "account.${harness_platform_secret_text.container_registry_username.id}"
    password_ref = "account.${harness_platform_secret_text.container_registry_password.id}"
  }
}
