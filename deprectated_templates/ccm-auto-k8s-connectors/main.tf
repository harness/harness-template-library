data "harness_platform_organization" "this" {
  identifier = var.organization_id
}

data "harness_platform_project" "this" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.this.id
}

resource "harness_platform_pipeline" "this" {
  identifier  = "ccm_auto_k8s_connectors"
  name        = "CCM Auto K8s Connectors"
  description = "Auto create k8s and ccm connectors for account level delegates."
  tags        = local.common_tags_tuple
  org_id      = data.harness_platform_organization.this.id
  project_id  = data.harness_platform_project.this.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/ccm_auto_k8s_connectors.yaml",
    {
      PIPELINE_IDENTIFIER : "ccm_auto_k8s_connectors"
      PIPELINE_NAME : "CCM Auto K8s Connectors"
      PIPELINE_DESCRIPTION : "Auto create k8s and ccm connectors for account level delegates."
      TAGS : yamlencode(local.common_tags)
      ORGANIZATION_ID : data.harness_platform_organization.this.id
      PROJECT_ID : data.harness_platform_project.this.id

      STEP_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/pipelines/snippets/step_group_infra.yaml",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : (var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped")
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )

      HARNESS_ENDPOINT : replace(var.harness_platform_url, "/gateway", "")
      HARNESS_PLATFORM_API_KEY_SECRET : var.existing_harness_platform_key_ref

      CONNECTOR_PREFIX : var.connector_prefix
      DOCKER_CONNECTOR : var.docker_connector
      IMAGE : var.image
    }
  )
}

resource "harness_platform_triggers" "this" {
  name       = "Cron"
  identifier = "cron"
  org_id     = data.harness_platform_organization.this.id
  project_id = data.harness_platform_project.this.id
  target_id  = harness_platform_pipeline.this.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/cron.yaml",
    {
      TRIGGER_IDENTIFIER : "cron"
      TRIGGER_NAME : "Cron"
      PIPELINE_ID : harness_platform_pipeline.this.id
      TAGS : yamlencode(local.common_tags)
      ORGANIZATION_ID : data.harness_platform_organization.this.id
      PROJECT_ID : data.harness_platform_project.this.id

      CRON = var.cron
    }
  )
}