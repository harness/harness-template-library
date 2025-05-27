resource "harness_platform_template" "stp_STO_ConfigManager_Repo_v1" {
  depends_on = [harness_platform_repo.repository]
  identifier = "stp_STO_ConfigManager_Repo"
  name       = "STO ConfigManager Repo"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = "v1"
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/steps/v1/stp_STO_ConfigManager_Repo.yaml",
    {
      TEMPLATE_IDENTIFIER : "stp_STO_ConfigManager_Repo"
      TEMPLATE_NAME : "STO ConfigManager Repo"
      TEMPLATE_DESC : "Clones Harness STO Configuration Manager repository"
      TEMPLATE_VERSION : "v1"
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id

      # STO ConfigManager Repo Management
      STO_GLOBAL_REPO_CONNECTOR : var.sto_config_mgr_connector_ref
      STO_GLOBAL_REPO_NAME : var.sto_config_mgr_connector_ref != "skipped" ? var.sto_config_mgr_repo : "account.${harness_platform_repo.repository.0.identifier}"

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
