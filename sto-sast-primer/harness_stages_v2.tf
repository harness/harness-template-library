resource "harness_platform_template" "sta_STO_SAST_SCA_Primer_v2" {
  depends_on = [
    time_sleep.steps,
    time_sleep.step_groups
  ]
  identifier = "sta_STO_SAST_SCA_Primer"
  name       = "STO SAST SCA Primer"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = "v2"
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/stages/v2/sta_STO_SAST_SCA_Primer.yaml",
    {
      TEMPLATE_IDENTIFIER : "sta_STO_SAST_SCA_Primer"
      TEMPLATE_NAME : "STO SAST SCA Primer"
      TEMPLATE_VERSION : "v2"
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "Performs SCA and SAST scans against a repository"

      # Scanner Templates
      GITLEAKS_TEMPLATE_ID : contains(var.enabled_scanners, "gitleaks") ? "${local.tier_handler}${harness_platform_template.stg_Gitleaks_Scans_v2.0.id}" : "skipped"
      GITLEAKS_TEMPLATE_VERSION : contains(var.enabled_scanners, "gitleaks") ? harness_platform_template.stg_Gitleaks_Scans_v2.0.version : "skipped"
      OSV_TEMPLATE_ID : contains(var.enabled_scanners, "osv") ? "${local.tier_handler}${harness_platform_template.stg_OSV_SCA_v2.0.id}" : "skipped"
      OSV_TEMPLATE_VERSION : contains(var.enabled_scanners, "osv") ? harness_platform_template.stg_OSV_SCA_v2.0.version : "skipped"
      OWASP_TEMPLATE_ID : contains(var.enabled_scanners, "owasp") ? "${local.tier_handler}${harness_platform_template.stg_OWASP_Dependency_Check_v2.0.id}" : "skipped"
      OWASP_TEMPLATE_VERSION : contains(var.enabled_scanners, "owasp") ? harness_platform_template.stg_OWASP_Dependency_Check_v2.0.version : "skipped"
      SEMGREP_TEMPLATE_ID : contains(var.enabled_scanners, "semgrep") ? "${local.tier_handler}${harness_platform_template.stg_Semgrep_Sast_v2.0.id}" : "skipped"
      SEMGREP_TEMPLATE_VERSION : contains(var.enabled_scanners, "semgrep") ? harness_platform_template.stg_Semgrep_Sast_v2.0.version : "skipped"

      # Scanner CPU&Memory Values
      GITLEAKS_OVERRIDE_CPU : var.gitleaks_override_cpu
      GITLEAKS_OVERRIDE_MEM : var.gitleaks_override_mem
      OSV_OVERRIDE_CPU : var.osv_override_cpu
      OSV_OVERRIDE_MEM : var.osv_override_mem
      OWASP_OVERRIDE_CPU : var.owasp_override_cpu
      OWASP_OVERRIDE_MEM : var.owasp_override_mem
      SEMGREP_OVERRIDE_CPU : var.semgrep_override_cpu
      SEMGREP_OVERRIDE_MEM : var.semgrep_override_mem

      # STO ConfigManager Repo Management
      STO_GLOBAL_REPO_CONNECTOR : var.sto_config_mgr_connector_ref
      STO_GLOBAL_REPO_NAME : var.sto_config_mgr_connector_ref != "skipped" ? var.sto_config_mgr_repo : "account.${harness_platform_repo.repository.0.identifier}"
      CONFIGMGR_TEMPLATE_ID : "${local.tier_handler}${harness_platform_template.stp_STO_ConfigManager_Repo_v1.id}"
      CONFIGMGR_TEMPLATE_VERSION : harness_platform_template.stp_STO_ConfigManager_Repo_v1.version

      STAGE_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/stages/snippets/iacm_infrastructure.yaml",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : (var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped")
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
