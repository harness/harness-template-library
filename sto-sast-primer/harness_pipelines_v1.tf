resource "harness_platform_template" "pipe_STO_SAST_SCA_Pipeline_HCR_v1" {
  depends_on = [time_sleep.pipelines_v2]
  count      = var.should_support_hcr ? 1 : 0
  identifier = "pipe_STO_SAST_SCA_Pipeline_HCR"
  name       = "STO SAST SCA Pipeline - HCR"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = "v1"
  is_stable  = false
  template_yaml = templatefile(
    "${path.module}/templates/pipelines/v1/pipe_STO_SAST_SCA_Pipeline.yaml",
    {
      TEMPLATE_IDENTIFIER : "pipe_STO_SAST_SCA_Pipeline_HCR"
      TEMPLATE_NAME : "STO SAST SCA Pipeline - HCR"
      TEMPLATE_VERSION : "v1"
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "[Requires Harness Code] Pipeline Example to scan an application repository with supported SCA and SAST scanners"

      STAGE_TEMPLATE_ID : "${local.tier_handler}${harness_platform_template.sta_STO_SAST_SCA_Primer_v1.id}"
      STAGE_TEMPLATE_VERSION : harness_platform_template.sta_STO_SAST_SCA_Primer_v1.version

      # Included Scanners
      INCLUDE_GITLEAKS : contains(var.enabled_scanners, "gitleaks") ? "include" : "skipped"
      INCLUDE_OSV : contains(var.enabled_scanners, "osv") ? "include" : "skipped"
      INCLUDE_OWASP : contains(var.enabled_scanners, "owasp") ? "include" : "skipped"
      INCLUDE_SEMGREP : contains(var.enabled_scanners, "semgrep") ? "include" : "skipped"

      USE_HCR = true

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_template" "pipe_STO_SAST_SCA_Pipeline_v1" {
  depends_on = [time_sleep.pipelines_v2]
  identifier = "pipe_STO_SAST_SCA_Pipeline"
  name       = "STO SAST SCA Pipeline"
  org_id     = var.organization_id
  project_id = var.project_id
  version    = "v1"
  is_stable  = false
  template_yaml = templatefile(
    "${path.module}/templates/pipelines/v1/pipe_STO_SAST_SCA_Pipeline.yaml",
    {
      TEMPLATE_IDENTIFIER : "pipe_STO_SAST_SCA_Pipeline"
      TEMPLATE_NAME : "STO SAST SCA Pipeline"
      TEMPLATE_VERSION : "v1"
      ORGANIZATION_ID : var.organization_id
      PROJECT_ID : var.project_id
      TEMPLATE_DESC : "Pipeline Example to scan an application repository with supported SCA and SAST scanners"

      STAGE_TEMPLATE_ID : "${local.tier_handler}${harness_platform_template.sta_STO_SAST_SCA_Primer_v1.id}"
      STAGE_TEMPLATE_VERSION : harness_platform_template.sta_STO_SAST_SCA_Primer_v1.version

      # Included Scanners
      INCLUDE_GITLEAKS : contains(var.enabled_scanners, "gitleaks") ? "include" : "skipped"
      INCLUDE_OSV : contains(var.enabled_scanners, "osv") ? "include" : "skipped"
      INCLUDE_OWASP : contains(var.enabled_scanners, "owasp") ? "include" : "skipped"
      INCLUDE_SEMGREP : contains(var.enabled_scanners, "semgrep") ? "include" : "skipped"

      USE_HCR = false

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
