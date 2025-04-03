resource "harness_platform_connector_gitlab" "source_code_manager" {
  lifecycle {
    precondition {
      condition     = local.resource_self_hosted_ready == ""
      error_message = local.resource_self_hosted_ready
    }
  }
  count               = var.support_self_hosted ? 1 : 0
  identifier          = "buildfarm_source_code_manager"
  name                = "BuildFarm Source Code Manager"
  description         = "BuildFarm Source Code Manager Connector"
  tags                = local.common_tags_tuple
  url                 = var.source_code_manager_url
  connection_type     = var.source_code_manager_connection_type
  validation_repo     = var.source_code_manager_validation_repo
  delegate_selectors  = var.delegate_selectors
  execute_on_delegate = true

  credentials {
    dynamic "http" {
      for_each = var.source_code_manager_auth_type == "http" ? [1] : []
      content {
        username  = var.scm_username
        token_ref = var.scm_password
      }
    }

    dynamic "ssh" {
      for_each = var.source_code_manager_auth_type == "ssh" ? [1] : []
      content {
        ssh_key_ref = var.scm_ssh_key
      }
    }
  }

  dynamic "api_authentication" {
    for_each = var.enable_api_authentication ? [1] : []
    content {
      token_ref = var.scm_password
    }
  }
}

resource "harness_platform_connector_gitlab" "source_code_manager_cloud" {
  lifecycle {
    precondition {
      condition     = local.resource_cloud_ready == ""
      error_message = local.resource_cloud_ready
    }
  }
  count               = var.support_harness_cloud ? 1 : 0
  identifier          = "buildfarm_source_code_manager_cloud"
  name                = "BuildFarm Source Code Manager - Cloud"
  description         = "BuildFarm Source Code Manager Connector for Harness CI Cloud builds"
  tags                = local.common_tags_tuple
  url                 = var.source_code_manager_url
  connection_type     = var.source_code_manager_connection_type
  validation_repo     = var.source_code_manager_validation_repo
  execute_on_delegate = false

  credentials {
    dynamic "http" {
      for_each = var.source_code_manager_auth_type == "http" ? [1] : []
      content {
        username  = var.scm_username
        token_ref = var.scm_password
      }
    }

    dynamic "ssh" {
      for_each = var.source_code_manager_auth_type == "ssh" ? [1] : []
      content {
        ssh_key_ref = var.scm_ssh_key
      }
    }
  }

  dynamic "api_authentication" {
    for_each = var.enable_api_authentication ? [1] : []
    content {
      token_ref = var.scm_password
    }
  }
}
