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

module "cr_docker" {
  count  = local.container_registry_type == "docker" ? 1 : 0
  source = "./modules/container_registry/docker"

  container_registry_url      = var.container_registry_url
  container_registry_username = "account.${harness_platform_secret_text.container_registry_username.id}"
  container_registry_password = "account.${harness_platform_secret_text.container_registry_password.id}"
  support_self_hosted         = local.support_self_hosted
  support_harness_cloud       = local.support_harness_cloud
  tags                        = local.common_tags
}

module "cr_artifactory" {
  count  = local.container_registry_type == "artifactory" ? 1 : 0
  source = "./modules/container_registry/artifactory"

  container_registry_url      = var.container_registry_url
  container_registry_username = "account.${harness_platform_secret_text.container_registry_username.id}"
  container_registry_password = "account.${harness_platform_secret_text.container_registry_password.id}"
  support_self_hosted         = local.support_self_hosted
  support_harness_cloud       = local.support_harness_cloud
  tags                        = local.common_tags
}

module "cr_aws" {
  count  = local.container_registry_type == "aws" ? 1 : 0
  source = "./modules/container_registry/aws"

  container_registry_username       = "account.${harness_platform_secret_text.container_registry_username.id}"
  container_registry_password       = "account.${harness_platform_secret_text.container_registry_password.id}"
  support_self_hosted               = local.support_self_hosted
  support_harness_cloud             = local.support_harness_cloud
  region                            = var.region
  authentication_type_self_hosted   = var.authentication_type_self_hosted
  authentication_type_harness_cloud = var.authentication_type_harness_cloud
  iam_role_arn                      = var.iam_role_arn
  tags                              = local.common_tags
}
