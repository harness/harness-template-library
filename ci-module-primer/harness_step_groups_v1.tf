resource "harness_platform_template" "stg_build_and_scan_container_image_v1" {
  identifier = "Build_and_Scan_Container_Image"
  name       = "Build and Scan Container Image"
  org_id     = local.common_template_vars["ORGANIZATION_ID"]
  project_id = local.common_template_vars["PROJECT_ID"]
  version    = "v1"
  is_stable  = true

  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_build_and_scan_container_image.yaml",
    merge(local.common_template_vars, {
      TEMPLATE_IDENTIFIER   = "Build_and_Scan_Container_Image"
      TEMPLATE_NAME         = "Build and Scan Container Image"
      TEMPLATE_VERSION      = "v1"
      KUBERNETES_CONNECTOR  = var.kubernetes_connector
      INCLUDE_STO           = var.include_security_testing
      ANCHORE_GRYPE_FAIL_ON = lower(var.sto_anchore_grype_fail_on)
    })
  )

  tags = local.common_tags_tuple
}

resource "harness_platform_template" "stg_code_smells_and_linting_v1" {
  count      = var.include_security_testing ? 1 : 0
  identifier = "Code_Smells_and_Linting"
  name       = "Code Smells and Linting"
  org_id     = local.common_template_vars["ORGANIZATION_ID"]
  project_id = local.common_template_vars["PROJECT_ID"]
  version    = "v1"
  is_stable  = true

  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_code_smells_and_linting.yaml",
    merge(local.common_template_vars, {
      TEMPLATE_IDENTIFIER          = "Code_Smells_and_Linting"
      TEMPLATE_NAME                = "Code Smells and Linting"
      TEMPLATE_VERSION             = "v1"
      CONTAINER_REGISTRY_CONNECTOR = var.default_container_connector
    })
  )

  tags = local.common_tags_tuple
}

resource "harness_platform_template" "stg_supply_chain_security_v1" {
  count      = var.include_supply_chain_security ? 1 : 0
  identifier = "Supply_Chain_Security"
  name       = "Supply Chain Security"
  org_id     = local.common_template_vars["ORGANIZATION_ID"]
  project_id = local.common_template_vars["PROJECT_ID"]
  version    = "v1"
  is_stable  = true

  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_supply_chain_security.yaml",
    merge(local.common_template_vars, {
      TEMPLATE_IDENTIFIER          = "Supply_Chain_Security"
      TEMPLATE_NAME                = "Supply Chain Security"
      TEMPLATE_VERSION             = "v1"
      CONTAINER_REGISTRY_CONNECTOR = var.default_container_connector
    })
  )

  tags = local.common_tags_tuple
}
