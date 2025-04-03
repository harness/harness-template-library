
resource "harness_platform_connector_artifactory" "artifact_manager" {
  count       = var.support_self_hosted ? 1 : 0
  identifier  = "buildfarm_artifact_manager"
  name        = "BuildFarm Artifact Manager"
  description = "BuildFarm Artifact Manager Connector"
  tags        = local.common_tags_tuple

  url                = var.artifact_manager_url
  delegate_selectors = var.artifact_manager_delegate
  # execute_on_delegate = true
  credentials {
    username_ref = var.artifact_manager_username
    password_ref = var.artifact_manager_password
  }
}

resource "harness_platform_connector_artifactory" "artifact_manager_cloud" {
  count       = var.support_harness_cloud ? 1 : 0
  identifier  = "buildfarm_artifact_manager_cloud"
  name        = "BuildFarm Artifact Manager - Cloud"
  description = "BuildFarm Artifact Manager Connector for Harness CI Cloud builds"
  tags        = local.common_tags_tuple

  url = var.artifact_manager_url
  # execute_on_delegate = false
  credentials {
    username_ref = var.artifact_manager_username
    password_ref = var.artifact_manager_password
  }
}
