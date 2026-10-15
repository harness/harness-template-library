resource "harness_platform_template" "stg_scs_ecr_ci_v1" {
  identifier = "SCS_ECR_CI"
  name       = "SCS ECR CI"
  org_id     = local.common_template_vars["ORGANIZATION_ID"]
  project_id = local.common_template_vars["PROJECT_ID"]
  version    = "v1"
  is_stable  = true

  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_scs_ecr_ci.yaml",
    merge(local.common_template_vars, {
      TEMPLATE_IDENTIFIER = "SCS_ECR_CI"
      TEMPLATE_NAME       = "SCS ECR CI"
      TEMPLATE_VERSION    = "v1"
    })
  )

  tags = local.common_tags_tuple
}

resource "harness_platform_template" "stg_scs_ecr_cd_v1" {
  identifier = "SCS_ECR_CD"
  name       = "SCS ECR CD"
  org_id     = local.common_template_vars["ORGANIZATION_ID"]
  project_id = local.common_template_vars["PROJECT_ID"]
  version    = "v1"
  is_stable  = true

  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_scs_ecr_cd.yaml",
    merge(local.common_template_vars, {
      TEMPLATE_IDENTIFIER = "SCS_ECR_CD"
      TEMPLATE_NAME       = "SCS ECR CD"
      TEMPLATE_VERSION    = "v1"
    })
  )

  tags = local.common_tags_tuple
}
