
data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

resource "harness_platform_repo" "repository" {
  count          = var.git_connector_ref != null ? 0 : 1
  identifier     = "harness-delegate-setup"
  description    = "Repository to dynamically build and manage Harness Delegate images"
  org_id         = data.harness_platform_organization.selected.id
  project_id     = data.harness_platform_project.selected.id
  default_branch = "main"
}

resource "harness_platform_pipeline" "Harness_Delegate_Image_Factory" {
  depends_on = [time_sleep.stg_template_setup]
  identifier = "Harness_Delegate_Image_Factory"
  name       = "Harness Delegate Image Factory"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_Harness_Delegate_Image_Factory.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : "Harness_Delegate_Image_Factory"
      PIPELINE_NAME : "Harness Delegate Image Factory"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      HARNESS_PLATFORM_API_KEY : var.existing_harness_platform_key_ref

      # CI Codebase Details
      CI_CODEBASE_CONNECTOR : var.git_connector_ref
      CI_CODEBASE_REPO : var.git_repository_name

      # CI Infrastructure Variables
      HARNESS_K8s_CONNECTOR : var.harness_k8s_connector
      HARNESS_K8s_NAMESPACE : var.harness_k8s_namespace
      HARNESS_K8s_NODESELECTORS : yamlencode(var.harness_k8s_node_selectors)
      HARNESS_IMAGE_CONNECTOR : var.harness_override_image_connector

      # Docker Image Regisry Details
      DOCKER_REGISTRY_NAME : var.container_registry_name
      DOCKER_REGISTRY_ID : var.container_registry_connector_id

      # Pipeline Control Mechanisms
      INCLUDE_IMAGE_TEST_SCAN : var.include_image_test_scan
      INCLUDE_IMAGE_SBOM : var.include_image_sbom

      # Pipeline Step Type Controls
      Build_and_Scan_Container_Image_TEMPLATE : harness_platform_template.stg_Build_and_Scan_Container_Image.id
      Build_and_Scan_Container_Image_VERSION : harness_platform_template.stg_Build_and_Scan_Container_Image.version
      Publish_Scanned_and_Cached_Container_Image_TEMPLATE : harness_platform_template.stg_Publish_Scanned_and_Cached_Container_Image.id
      Publish_Scanned_and_Cached_Container_Image_VERSION : harness_platform_template.stg_Publish_Scanned_and_Cached_Container_Image.version
      Publish_Container_Image_TEMPLATE : harness_platform_template.stg_Publish_Container_Image.id
      Publish_Container_Image_VERSION : harness_platform_template.stg_Publish_Container_Image.version

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
