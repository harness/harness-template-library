resource "harness_platform_connector_gcp" "container_registry" {
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

  dynamic "manual" {
    for_each = var.authentication_type_self_hosted == "manual" ? [1] : []
    content {
      secret_key_ref     = var.container_registry_password
      delegate_selectors = var.delegate_selectors
    }
  }

  dynamic "inherit_from_delegate" {
    for_each = var.authentication_type_self_hosted == "delegate" ? [1] : []
    content {
      delegate_selectors = var.delegate_selectors
    }
  }

  dynamic "oidc_authentication" {
    for_each = var.authentication_type_self_hosted == "oidc" ? [1] : []
    content {
      workload_pool_id      = var.oidc_workload_pool_id
      provider_id           = var.oidc_provider_id
      gcp_project_id        = var.oidc_project_id
      service_account_email = var.oidc_service_account_email
      delegate_selectors    = var.delegate_selectors
    }
  }
}

resource "harness_platform_connector_gcp" "container_registry_cloud" {
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
      secret_key_ref = var.container_registry_password
    }
  }

  dynamic "oidc_authentication" {
    for_each = var.authentication_type_harness_cloud == "oidc" ? [1] : []
    content {
      workload_pool_id      = var.oidc_workload_pool_id
      provider_id           = var.oidc_provider_id
      gcp_project_id        = var.oidc_project_id
      service_account_email = var.oidc_service_account_email
    }
  }
}