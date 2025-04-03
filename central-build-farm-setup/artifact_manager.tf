resource "harness_platform_secret_text" "artifact_manager_username" {
  identifier  = "buildfarm_artifact_manager_username"
  name        = "Buildfarm Artifact Manager Username"
  description = "Username used by BuildFarm Artifact Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_artifact_manager"],
    local.common_tags_tuple
  ])

  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = "changeme"
}

resource "harness_platform_secret_text" "artifact_manager_password" {
  identifier  = "buildfarm_artifact_manager_password"
  name        = "Buildfarm Artifact Manager Password"
  description = "Password used by BuildFarm Artifact Manager Connector"
  tags = flatten([
    ["required_for:buildfarm_artifact_manager"],
    local.common_tags_tuple
  ])

  secret_manager_identifier = "harnessSecretManager"
  value_type                = "Inline"
  value                     = "changeme"
}

module "ar_http_helm" {
  count  = local.artifact_manager_type == "http_helm" ? 1 : 0
  source = "./modules/artifact_manager/http_helm"

  artifact_manager_url       = var.artifact_manager_url
  artifact_manager_auth_type = var.artifact_manager_auth_type
  artifact_manager_username  = var.artifact_manager_auth_type == "UsernamePassword" ? "account.${harness_platform_secret_text.artifact_manager_username.id}" : null
  artifact_manager_password  = var.artifact_manager_auth_type == "UsernamePassword" ? "account.${harness_platform_secret_text.artifact_manager_password.id}" : null
  support_self_hosted        = local.support_self_hosted
  tags                       = local.common_tags
}

module "ar_oci_helm" {
  count  = local.artifact_manager_type == "oci_helm" ? 1 : 0
  source = "./modules/artifact_manager/oci_helm"

  artifact_manager_url       = var.artifact_manager_url
  artifact_manager_auth_type = var.artifact_manager_auth_type
  artifact_manager_username  = var.artifact_manager_auth_type == "UsernamePassword" ? "account.${harness_platform_secret_text.artifact_manager_username.id}" : null
  artifact_manager_password  = var.artifact_manager_auth_type == "UsernamePassword" ? "account.${harness_platform_secret_text.artifact_manager_password.id}" : null
  support_self_hosted        = local.support_self_hosted
  support_harness_cloud      = local.support_harness_cloud
  tags                       = local.common_tags
}

module "ar_nexus" {
  count  = local.artifact_manager_type == "nexus" ? 1 : 0
  source = "./modules/artifact_manager/nexus"

  artifact_manager_url       = var.artifact_manager_url
  nexus_version              = var.nexus_version
  artifact_manager_auth_type = var.artifact_manager_auth_type
  artifact_manager_username  = var.artifact_manager_auth_type == "UsernamePassword" ? "account.${harness_platform_secret_text.artifact_manager_username.id}" : null
  artifact_manager_password  = var.artifact_manager_auth_type == "UsernamePassword" ? "account.${harness_platform_secret_text.artifact_manager_password.id}" : null
  support_self_hosted        = local.support_self_hosted
  tags                       = local.common_tags
}

module "ar_artifactory" {
  count  = local.artifact_manager_type == "artifactory" ? 1 : 0
  source = "./modules/artifact_manager/artifactory"

  artifact_manager_url      = var.artifact_manager_url
  artifact_manager_username = "account.${harness_platform_secret_text.artifact_manager_username.id}"
  artifact_manager_password = "account.${harness_platform_secret_text.artifact_manager_password.id}"
  support_self_hosted       = local.support_self_hosted
  support_harness_cloud     = local.support_harness_cloud
  tags                      = local.common_tags
}
