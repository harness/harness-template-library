resource "harness_platform_pipeline" "pipeline" {
  identifier  = local.fmt_identifier
  name        = var.pipeline_name
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "CI Golden Standard pipeline for ${var.pipeline_name}"
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_ci_golden_standard_instance.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : local.fmt_identifier
      PIPELINE_NAME : var.pipeline_name
      DESCRIPTION : "CI Golden Standard pipeline for ${var.pipeline_name}"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "CI Golden Standard pipeline for ${var.pipeline_name}"

      TEMPLATE_ID : "${local.template_hierarchy}${data.harness_platform_template.selected.id}"
      TEMPLATE_VERSION : data.harness_platform_template.selected.version

      # Source Code Details
      REPOSITORY_CONNECTOR : var.repository_connector_ref
      REPOSITORY_PATH : var.repository_path

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_input_set" "defaults" {
  identifier  = "Default_Inputs"
  name        = "Default Inputs"
  pipeline_id = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/input_sets/default.yaml",
    {
      INPUTSET_IDENTIFIER : "Default_Inputs"
      INPUTSET_NAME : "Default Inputs"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "This trigger will fire when a push event is received."
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}


resource "harness_platform_triggers" "primary" {
  count       = var.branches != "skipped" ? 1 : 0
  identifier  = "Push_Trigger"
  name        = "Push Trigger"
  target_id   = harness_platform_pipeline.pipeline.id
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "This trigger will fire when a push event is received."
  yaml = templatefile(
    "${path.module}/templates/pipelines/triggers/trigger_Repo.yaml",
    {
      # Trigger Setup Details
      TRIGGER_IDENTIFIER : "Push_Trigger"
      TRIGGER_NAME : "Push Trigger"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.pipeline.id
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "This trigger will fire when a push event is received."

      WEBHOOK_TEMPLATE = templatefile(
        "${path.module}/templates/pipelines/triggers/snippets/snp_${lower(var.webhook_type)}_webhook.yaml",
        {
          REPOSITORY_CONNECTOR : var.repository_connector_ref
          REPOSITORY_PATH : var.repository_path
          TARGET_BRANCH : var.branches
        }
      )

      INPUT_SET : harness_platform_input_set.defaults.id

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
