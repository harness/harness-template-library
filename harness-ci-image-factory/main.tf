data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

resource "harness_platform_pipeline" "image_factory" {
  identifier  = "Harness_CI_Image_Factory"
  name        = "Harness Image Factory"
  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  description = "Mirror and Replicate current Harness Images into private repository"
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_harness_ci_image_factory.yaml.tpl",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : "Harness_CI_Image_Factory"
      PIPELINE_NAME : "Harness Image Factory"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Mirror and Replicate current Harness Images into private repository"

      # Pipeline Inputs
      HARNESS_REGISTRY_SOURCE : var.harness_ci_image_source_repository
      CUSTOMER_REGISTRY_TARGET : var.customer_image_target_repository
      CONTAINER_REGISTRY_USERNAME_REF : var.container_registry_username_ref
      CONTAINER_REGISTRY_PASSWORD_REF : var.container_registry_password_ref
      SHOULD_UPDATE_HARNESS_MGR : var.should_update_harness_mgr

      # Pipeline Configuration
      STEP_CONNECTOR_REF : var.pipeline_step_connector_ref
      HSF_SCRIPT_MGR_IMAGE : var.hsf_script_mgr_image
      HARNESS_IMAGE_PLUGIN : var.harness_image_migration_image
      MAX_CONCURRENCY : var.max_concurrency


      STAGE_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/snippets/infrastructure.yaml.tpl",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : (var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped")
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )
      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}

resource "harness_platform_triggers" "cron" {
  for_each   = toset(var.modules)
  identifier = "Schedule_Harness_Image_Updates_${replace(upper(each.value), "-", "_")}"
  name       = "Schedule Harness Image Updates ${upper(each.value)}"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  target_id  = harness_platform_pipeline.image_factory.identifier
  yaml = templatefile(
    "${path.module}/templates/pipelines/triggers/schedule_image_pull.yaml.tpl",
    {
      TRIGGER_IDENTIFIER : "Schedule_Harness_Image_Updates_${replace(upper(each.value), "-", "_")}"
      TRIGGER_NAME : "Schedule Harness Image Updates ${upper(each.value)}"
      PIPELINE_IDENTIFIER : harness_platform_pipeline.image_factory.identifier
      PIPELINE_NAME : harness_platform_pipeline.image_factory.name
      ORGANIZATION_ID : harness_platform_pipeline.image_factory.org_id
      PROJECT_ID : harness_platform_pipeline.image_factory.project_id
      SCHEDULE : var.scheduled_pipeline_execution_frequency
      ENABLED : tostring(var.should_trigger_pipeline_on_schedule)

      # Pipeline Inputs
      HARNESS_REGISTRY_SOURCE : var.harness_ci_image_source_repository
      CUSTOMER_REGISTRY_TARGET : var.customer_image_target_repository
      CONTAINER_REGISTRY_USERNAME_REF : var.container_registry_username_ref
      CONTAINER_REGISTRY_PASSWORD_REF : var.container_registry_password_ref
      SHOULD_UPDATE_HARNESS_MGR : var.should_update_harness_mgr
      MODULE : each.value

      TAGS : yamlencode(local.common_tags)
    }
  )
}
