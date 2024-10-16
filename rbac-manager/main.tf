
data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

resource "harness_platform_pipeline" "RBAC_Management" {
  identifier  = "RBAC_Management"
  name        = "RBAC Management"
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "This pipeline provides a centralized method for managing Group Membership via automation"
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_RBAC_Management.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : "RBAC_Management"
      PIPELINE_NAME : "RBAC Management"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "This pipeline provides a centralized method for managing Group Membership via automation"

      HARNESS_PLATFORM_URL : replace(var.harness_platform_url, "/gateway", "")
      HARNESS_PLATFORM_SECRET : "org.hsf_platform_api_key"

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
