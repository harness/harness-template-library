resource "harness_platform_connector_aws" "container_registry" {
  lifecycle {
    precondition {
      condition     = local.resource_self_hosted_ready == ""
      error_message = local.resource_self_hosted_ready
    }
  }
  count               = var.support_self_hosted ? 1 : 0
  identifier          = "buildfarm_container_registry"
  name                = "BuildFarm Container Registry"
  description         = "BuildFarm Container Registry Connector"
  execute_on_delegate = true
  tags                = local.common_tags_tuple

  dynamic "inherit_from_delegate" {
    for_each = var.authentication_type_self_hosted == "delegate" ? [1] : []
    content {
      region             = var.region
      delegate_selectors = var.delegate_selectors
    }
  }

  dynamic "manual" {
    for_each = var.authentication_type_self_hosted == "manual" ? [1] : []
    content {
      access_key_ref     = var.container_registry_username
      secret_key_ref     = var.container_registry_password
      region             = var.region
      delegate_selectors = var.delegate_selectors
    }
  }

  dynamic "irsa" {
    for_each = var.authentication_type_self_hosted == "irsa" ? [1] : []
    content {
      region             = var.region
      delegate_selectors = var.delegate_selectors
    }
  }

  dynamic "oidc_authentication" {
    for_each = var.authentication_type_self_hosted == "oidc" ? [1] : []
    content {
      iam_role_arn       = var.iam_role_arn
      region             = var.region
      delegate_selectors = var.delegate_selectors
    }
  }

  dynamic "cross_account_access" {
    for_each = local.cross_account_access ? [1] : []
    content {
      role_arn    = var.cross_account_role_arn
      external_id = var.cross_account_external_id
    }
  }
}

resource "harness_platform_connector_aws" "container_registry_cloud" {
  lifecycle {
    precondition {
      condition     = local.resource_cloud_ready == ""
      error_message = local.resource_cloud_ready
    }
  }
  count               = var.support_harness_cloud ? 1 : 0
  identifier          = "buildfarm_container_registry_cloud"
  name                = "BuildFarm Container Registry - Cloud"
  description         = "BuildFarm Container Registry Connector for Harness CI Cloud builds"
  execute_on_delegate = false
  tags                = local.common_tags_tuple

  dynamic "manual" {
    for_each = var.authentication_type_harness_cloud == "manual" ? [1] : []
    content {
      access_key_ref = var.container_registry_username
      secret_key_ref = var.container_registry_password
      region         = var.region
    }
  }

  dynamic "oidc_authentication" {
    for_each = var.authentication_type_harness_cloud == "oidc" ? [1] : []
    content {
      iam_role_arn       = var.iam_role_arn
      region             = var.region
      delegate_selectors = []
    }
  }
}
