resource "harness_platform_pipeline" "pipeline" {
  identifier  = local.fmt_identifier
  name        = harness_platform_repo.hcr.identifier
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Scan and Build pipeline for ${harness_platform_repo.hcr.identifier}"
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_STO_CI_HCR_build.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : local.fmt_identifier
      PIPELINE_NAME : harness_platform_repo.hcr.identifier
      DESCRIPTION : "Scan and Build pipeline for ${harness_platform_repo.hcr.identifier}"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id

      # Source Code Details
      REPOSITORY_PATH : harness_platform_repo.hcr.identifier

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
