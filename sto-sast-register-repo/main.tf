
data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

data "harness_platform_template" "selected" {
  identifier = "sta_STO_SAST_SCA_Primer"
}

resource "harness_platform_pipeline" "scanner" {
  identifier  = local.fmt_identifier
  name        = var.repository_name
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Repository pipeline built for ${var.repository_path}"
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_STO_Primer_Repo.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : local.fmt_identifier
      PIPELINE_NAME : var.repository_name
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Repository pipeline built for ${var.repository_path}"

      TEMPLATE_ID : "account.${data.harness_platform_template.selected.id}"
      TEMPLATE_VERSION : data.harness_platform_template.selected.version

      REPOSITORY_CONNECTOR : var.repository_connector_ref
      REPOSITORY_NAME : var.repository_name
      REPOSITORY_PATH : var.repository_path

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_triggers" "primary" {
  count       = var.branches != "skipped" ? 1 : 0
  identifier  = "Repository_Scans"
  name        = "Repository Scans"
  target_id   = harness_platform_pipeline.scanner.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Repository Pipeline Trigger"
  yaml = templatefile(
    "${path.module}/templates/pipelines/triggers/trigger_STO_Primer_Repo.yaml",
    {
      # Trigger Setup Details
      TRIGGER_IDENTIFIER : "Repository_Scans"
      TRIGGER_NAME : "Repository Scans"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.scanner.id
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Repository Pipeline Trigger"

      WEBHOOK_TEMPLATE = templatefile(
        "${path.module}/templates/pipelines/triggers/snippets/snp_${lower(var.webhook_type)}_webhook.yaml",
        {
          REPOSITORY_CONNECTOR : var.repository_connector_ref
          REPOSITORY_PATH : var.repository_path
          TARGET_BRANCH : var.branches
        }
      )

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
