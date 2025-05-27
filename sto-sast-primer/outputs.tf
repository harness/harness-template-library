locals {
  placement = (
    var.project_id != null
    ?
    "Within the Harness Project (${var.project_id}) inside Harness Organization (${var.organization_id})"
    :
    var.organization_id != null
    ?
    "Within the Harness Organization (${var.organization_id})"
    :
    "Deployed as Account-level Resources"
  )
  hcr_pipeline_template = var.should_support_hcr ? "${local.tier_handler}${harness_platform_template.pipe_STO_SAST_SCA_Pipeline_HCR_v2[0].id}" : "Not Deployed"
}

output "resource_placement" {
  value = local.placement
}

output "pipeline_template_id" {
  value = "${local.tier_handler}${harness_platform_template.pipe_STO_SAST_SCA_Pipeline_v2.id}"
}

output "pipeline_template_hcr_id" {
  value = local.hcr_pipeline_template
}

output "harness_sto_global_exclusions_repo" {
  value = var.sto_config_mgr_connector_ref != "skipped" ? var.sto_config_mgr_repo : harness_platform_repo.repository.0.git_url
}
