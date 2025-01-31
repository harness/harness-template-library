resource "harness_platform_connector_azure_cloud_provider" "container_registry" {
  count = var.support_self_hosted ? 1 : 0

  lifecycle {
    precondition {
      condition     = local.resource_self_hosted_ready == ""
      error_message = local.resource_self_hosted_ready
    }
  }

  identifier          = "buildfarm_container_registry"
  name                = "BuildFarm Container Registry"
  description         = "BuildFarm Container Registry Connector"
  tags                = local.common_tags_tuple
  execute_on_delegate = true

  credentials {
    type = var.authentication_type_self_hosted != "ManagedIdentity" ? "ManualConfig" : "InheritFromDelegate"

    # Manual Authentication (Secret or Certificate)
    dynamic "azure_manual_details" {
      for_each = var.authentication_type_self_hosted != "ManagedIdentity" ? [1] : []
      content {
        application_id = var.application_id
        tenant_id      = var.tenant_id

        auth {
          type = var.authentication_type_self_hosted # Must be either "Secret" or "Certificate"

          dynamic "azure_client_secret_key" {
            for_each = var.authentication_type_self_hosted == "Secret" ? [1] : []
            content {
              secret_ref = var.manual_credential_ref
            }
          }

          dynamic "azure_client_key_cert" {
            for_each = var.authentication_type_self_hosted == "Certificate" ? [1] : []
            content {
              certificate_ref = var.manual_credential_ref
            }
          }
        }
      }
    }

    # Managed Identity Authentication
    dynamic "azure_inherit_from_delegate_details" {
      for_each = var.authentication_type_self_hosted == "ManagedIdentity" ? [1] : []
      content {
        auth {
          type = var.identity_type # Must be "UserAssignedManagedIdentity" or "SystemAssignedManagedIdentity"

          dynamic "azure_msi_auth_ua" {
            for_each = var.identity_type == "UserAssignedManagedIdentity" ? [1] : []
            content {
              client_id = var.user_assigned_client_id
            }
          }
        }
      }
    }
  }

  azure_environment_type = var.azure_environment_type
  delegate_selectors     = var.delegate_selectors
}

resource "harness_platform_connector_azure_cloud_provider" "container_registry_cloud" {
  count = var.support_harness_cloud ? 1 : 0

  lifecycle {
    precondition {
      condition     = local.resource_cloud_ready == ""
      error_message = local.resource_cloud_ready
    }
  }

  identifier          = "buildfarm_container_registry_cloud"
  name                = "BuildFarm Container Registry - Cloud"
  description         = "BuildFarm Container Registry Connector for Harness CI Cloud builds"
  tags                = local.common_tags_tuple
  execute_on_delegate = false

  azure_environment_type = var.azure_environment_type

  credentials {
    type = "ManualConfig"

    # Manual Authentication (Secret or Certificate)
    dynamic "azure_manual_details" {
      for_each = var.authentication_type_harness_cloud != "ManagedIdentity" ? [1] : []
      content {
        application_id = var.application_id
        tenant_id      = var.tenant_id

        auth {
          type = var.authentication_type_harness_cloud # Must be either "Secret" or "Certificate"

          dynamic "azure_client_secret_key" {
            for_each = var.authentication_type_harness_cloud == "Secret" ? [1] : []
            content {
              secret_ref = var.manual_credential_ref
            }
          }

          dynamic "azure_client_key_cert" {
            for_each = var.authentication_type_harness_cloud == "Certificate" ? [1] : []
            content {
              certificate_ref = var.manual_credential_ref
            }
          }
        }
      }
    }
  }
}
