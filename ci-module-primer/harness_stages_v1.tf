resource "harness_platform_template" "sta_ci_stage_v1" {
  lifecycle {
    create_before_destroy = true
  }
  identifier = "CI_GoldenStandard_Container_Template"
  name       = "Build Containerized Applications"
  org_id     = local.common_template_vars["ORGANIZATION_ID"]
  project_id = local.common_template_vars["PROJECT_ID"]
  version    = "v1"
  is_stable  = true

  template_yaml = templatefile(
    "${path.module}/templates/stages/sta_ci_stage.yaml",
    merge(local.common_template_vars, {
      TEMPLATE_IDENTIFIER             = "CI_GoldenStandard_Container_Template"
      TEMPLATE_NAME                   = "Build Containerized Applications"
      TEMPLATE_DESC                   = "CI Golden Standard Stage template to build containerized Applications"
      TEMPLATE_VERSION                = "v1"
      CODE_SMELL_TEMPLATE             = var.include_security_testing ? "${local.tier_handler}${harness_platform_template.stg_code_smells_and_linting_v1[0].identifier}" : "skipped"
      CODE_SMELL_TEMPLATE_VERSION     = var.include_security_testing ? harness_platform_template.stg_code_smells_and_linting_v1[0].version : "skipped"
      BUILD_AND_SCAN_TEMPLATE         = "${local.tier_handler}${harness_platform_template.stg_build_and_scan_container_image_v1.identifier}"
      BUILD_AND_SCAN_TEMPLATE_VERSION = harness_platform_template.stg_build_and_scan_container_image_v1.version
      SCS_TEMPLATE                    = var.include_supply_chain_security ? "${local.tier_handler}${harness_platform_template.stg_supply_chain_security_v1[0].identifier}" : "skipped"
      SCS_TEMPLATE_VERSION            = var.include_supply_chain_security ? harness_platform_template.stg_supply_chain_security_v1[0].version : "skipped"
      INCLUDE_STO                     = var.include_security_testing
      INCLUDE_SCS                     = var.include_supply_chain_security
      STAGE_INFRASTRUCTURE = templatefile(
        "${path.module}/templates/stages/snippets/infrastructure.yaml",
        local.infrastructure_config
      )
    })
  )

  tags = local.common_tags_tuple

  depends_on = [
    time_sleep.step_groups
  ]
}
