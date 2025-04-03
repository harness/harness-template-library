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
  count  = contains(local.generic_container_registry_types, local.container_registry_type) ? 1 : 0
  source = "./modules/container_registry/docker"

  container_registry_url      = var.container_registry_url
  container_registry_username = "account.${harness_platform_secret_text.container_registry_username.id}"
  container_registry_password = "account.${harness_platform_secret_text.container_registry_password.id}"
  support_self_hosted         = local.support_self_hosted
  support_harness_cloud       = local.support_harness_cloud
  provider_type               = var.container_registry_provider_type
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
  cross_account_role_arn            = var.aws_cross_account_role_arn
  cross_account_external_id         = var.aws_cross_account_external_id
  tags                              = local.common_tags
}

module "cr_gcp" {
  count  = local.container_registry_type == "gcp" ? 1 : 0
  source = "./modules/container_registry/gcp"

  container_registry_password       = "account.${harness_platform_secret_text.container_registry_password.id}"
  support_self_hosted               = local.support_self_hosted
  support_harness_cloud             = local.support_harness_cloud
  authentication_type_self_hosted   = var.authentication_type_self_hosted
  authentication_type_harness_cloud = var.authentication_type_harness_cloud
  oidc_workload_pool_id             = var.gcp_workload_pool_id
  oidc_provider_id                  = var.gcp_provider_id
  oidc_project_id                   = var.gcp_project_id
  oidc_service_account_email        = var.gcp_service_account_email
  tags                              = local.common_tags
}

module "cr_azure" {
  count  = local.container_registry_type == "azure" ? 1 : 0
  source = "./modules/container_registry/azure"

  container_registry_password       = "account.${harness_platform_secret_text.container_registry_password.id}"
  support_self_hosted               = local.support_self_hosted
  support_harness_cloud             = local.support_harness_cloud
  authentication_type_self_hosted   = var.authentication_type_self_hosted
  authentication_type_harness_cloud = var.authentication_type_harness_cloud
  application_id                    = var.azure_application_id
  tenant_id                         = var.azure_tenant_id
  azure_environment_type            = var.azure_environment_type
  user_assigned_client_id           = var.azure_user_assigned_client_id
  tags                              = local.common_tags
}