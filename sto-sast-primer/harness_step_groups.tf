locals {
  semgrep_sast_template_version  = "v1"
  gitleaks_sast_template_version = "v1"
  owasp_sast_template_version    = "v1"
  osv_sast_template_version      = "v1"
}

resource "harness_platform_template" "stg_Gitleaks_Scans" {
  count      = contains(var.enabled_scanners, "gitleaks") ? 1 : 0
  identifier = "stg_Gitleaks_Scans"
  name       = "Gitleaks Scans"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = local.gitleaks_sast_template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_Gitleaks_Scans.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_Gitleaks_Scans"
      TEMPLATE_NAME : "Gitleaks Scans"
      TEMPLATE_VERSION : local.gitleaks_sast_template_version
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "Scan for security leaks within a repository"

      SCANNER_IMAGE_CONNECTOR : var.scanner_override_image_connector
      SCANNER_IMAGE_NAME : var.gitleaks_override_image_name

      STO_CONFIG_MGR_CONNECTOR : var.sto_config_mgr_connector
      STO_CONFIG_MGR_IMAGE : var.sto_config_mgr_image
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_template" "stg_OSV_SCA" {
  count      = contains(var.enabled_scanners, "osv") ? 1 : 0
  identifier = "stg_OSV_SCA"
  name       = "OSV SCA"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = local.osv_sast_template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_OSV_SCA.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_OSV_SCA"
      TEMPLATE_NAME : "OSV SCA"
      TEMPLATE_VERSION : local.osv_sast_template_version
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "Scan for Open Source Vulnerabilities within a repository"

      SCANNER_IMAGE_CONNECTOR : var.scanner_override_image_connector
      SCANNER_IMAGE_NAME : var.osv_override_image_name

      STO_CONFIG_MGR_CONNECTOR : var.sto_config_mgr_connector
      STO_CONFIG_MGR_IMAGE : var.sto_config_mgr_image
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_template" "stg_OWASP_Dependency_Check" {
  count      = contains(var.enabled_scanners, "owasp") ? 1 : 0
  identifier = "stg_OWASP_Dependency_Check"
  name       = "OWASP Dependency Check"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = local.owasp_sast_template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_OWASP_Dependency_Check.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_OWASP_Dependency_Check"
      TEMPLATE_NAME : "OWASP Dependency Check"
      TEMPLATE_VERSION : local.owasp_sast_template_version
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "Scan for Dependency issues and vulnerabilities within a repository"

      TOOLS_IMAGE_CONNECTOR : var.tools_image_connector
      TOOLS_IMAGE_NAME : var.tools_image_name
      SCANNER_IMAGE_CONNECTOR : var.scanner_override_image_connector
      SCANNER_IMAGE_NAME : var.owasp_override_image_name

      STO_CONFIG_MGR_CONNECTOR : var.sto_config_mgr_connector
      STO_CONFIG_MGR_IMAGE : var.sto_config_mgr_image
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_template" "stg_Semgrep_Sast" {
  count      = contains(var.enabled_scanners, "semgrep") ? 1 : 0
  identifier = "stg_Semgrep_Sast"
  name       = "Semgrep SAST"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = local.semgrep_sast_template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_Semgrep_Sast.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_Semgrep_Sast"
      TEMPLATE_NAME : "Semgrep SAST"
      TEMPLATE_VERSION : local.semgrep_sast_template_version
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "Scan for vulnerabilities within a repository"

      SCANNER_IMAGE_CONNECTOR : var.scanner_override_image_connector
      SCANNER_IMAGE_NAME : var.semgrep_override_image_name

      STO_CONFIG_MGR_CONNECTOR : var.sto_config_mgr_connector
      STO_CONFIG_MGR_IMAGE : var.sto_config_mgr_image
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "time_sleep" "step_groups" {
  depends_on = [
    harness_platform_template.stg_Gitleaks_Scans,
    harness_platform_template.stg_OSV_SCA,
    harness_platform_template.stg_OWASP_Dependency_Check,
    harness_platform_template.stg_Semgrep_Sast
  ]

  destroy_duration = "15s"
}
