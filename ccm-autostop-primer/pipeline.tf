# Create a pipeline that will modify a Harness service to have the required variables
data "harness_platform_organization" "pipeline" {
  identifier = var.pipeline_organization_id
}

data "harness_platform_project" "pipeline" {
  identifier = var.pipeline_project_id
  org_id     = data.harness_platform_organization.pipeline.id
}

resource "harness_platform_pipeline" "add_autostopping_variables" {
  identifier = "add_autostopping_variables"
  name       = "Add Autostopping Variables"
  org_id     = data.harness_platform_organization.pipeline.id
  project_id = data.harness_platform_project.pipeline.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/add_autostopping_variables.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : "add_autostopping_variables"
      PIPELINE_NAME : "Add Autostopping Variables"
      ORGANIZATION_ID : data.harness_platform_organization.pipeline.id
      PROJECT_ID : data.harness_platform_project.pipeline.id

      STEP_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/pipelines/snippets/iacm_infrastructure.yaml",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : (var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped")
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )

      TAGS : yamlencode(local.common_tags)

      HARNESS_ENDPOINT : replace(var.harness_platform_url, "/gateway", "")
      HARNESS_PLATFORM_API_KEY_SECRET : var.existing_harness_platform_key_ref

      DOCKER_CONNECTOR : var.docker_connector
      IMAGE : var.image
    }
  )
  tags = local.common_tags_tuple
}