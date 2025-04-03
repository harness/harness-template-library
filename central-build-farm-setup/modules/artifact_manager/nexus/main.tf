resource "harness_platform_connector_nexus" "artifact_manager" {
  lifecycle {
    precondition {
      condition     = local.resource_self_hosted_ready == ""
      error_message = local.resource_self_hosted_ready
    }
  }
  count              = var.support_self_hosted ? 1 : 0
  identifier         = "buildfarm_artifact_manager"
  name               = "BuildFarm Artifact Manager"
  description        = "BuildFarm Artifact Manager Connector"
  tags               = local.common_tags_tuple
  url                = var.artifact_manager_url
  version            = var.nexus_version
  delegate_selectors = var.artifact_manager_delegate

  dynamic "credentials" {
    for_each = var.artifact_manager_auth_type == "UsernamePassword" ? [1] : []
    content {
      username     = var.artifact_manager_username
      password_ref = var.artifact_manager_password
    }
  }
}
