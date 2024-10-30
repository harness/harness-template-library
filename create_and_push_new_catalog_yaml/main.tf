data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

resource "harness_platform_repo" "idp_service_catalog" {
  count          = var.harness_create_repo ? 1 : 0
  identifier     = var.git_repository_name
  description    = "Repository for IDP Service Catalogs"
  org_id         = contains(["HarnessProject", "HarnessOrganization"], var.git_connector_type) ? data.harness_platform_organization.selected.id : null
  project_id     = contains(["HarnessProject"], var.git_connector_type) ? data.harness_platform_project.selected.id : null
  default_branch = var.git_branch_name
}

resource "harness_platform_pipeline" "create_and_push_new_catalog_yaml" {
  identifier = "create_and_push_new_catalog_yaml"
  name       = "Create and Push New Catalog YAML"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_create_and_push_new_catalog_yaml.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : "create_and_push_new_catalog_yaml"
      PIPELINE_NAME : "Create and Push New Catalog YAML"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id

      # Codebase Details
      CODEBASE_CONNECTOR : var.git_connector_ref
      CODEBASE_CONNECTOR_TYPE : var.git_connector_type
      CODEBASE_REPO : var.git_repository_name
      CODEBASE_ORG : contains(["HarnessProject", "HarnessOrganization"], var.git_connector_type) ? data.harness_platform_organization.selected.id : var.git_organization_name
      CODEBASE_BRANCH : var.git_branch_name
      CODEBASE_WORKSPACE : var.git_workspace_name
      CODEBASE_GROUPPATH : var.git_grouppath_name
      CODEBASE_PROJECT : contains(["HarnessProject"], var.git_connector_type) ? data.harness_platform_project.selected.id : var.git_project_name

      STAGE_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/pipelines/snippets/iacm_infrastructure.yaml",
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