
data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

resource "harness_platform_repo" "repository" {
  count          = contains([null, "skipped"], var.git_connector_ref) ? 1 : 0
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

      KUBERNETES_CONNECTOR : var.kubernetes_connector
      STAGE_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/pipelines/snippets/iacm_infrastructure.yaml",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : (var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped")
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )

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

resource "harness_platform_pipeline" "Mirror_Harness_Delegate_Setup" {
  count      = contains([null, "skipped"], var.git_connector_ref) ? 1 : 0
  depends_on = [time_sleep.stg_template_setup]
  identifier = "Mirror_Harness_Delegate_Setup"
  name       = "Mirror Harness Delegate Setup"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_Mirror_Harness_Delegate_Setup.yaml",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : "Mirror_Harness_Delegate_Setup"
      PIPELINE_NAME : "Mirror Harness Delegate Setup"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id

      # CI Codebase Details
      CI_CODEBASE_CONNECTOR : var.git_connector_ref
      CI_CODEBASE_REPO : var.git_repository_name
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      STAGE_INFRASTRUCTURE : templatefile(
        "${path.module}/templates/pipelines/snippets/iacm_infrastructure.yaml",
        {
          KUBERNETES_CONNECTOR : var.kubernetes_connector
          KUBERNETES_NAMESPACE : var.kubernetes_namespace
          KUBERNETES_NODESELECTORS : (var.kubernetes_node_selectors != {} ? yamlencode(var.kubernetes_node_selectors) : "skipped")
          KUBERNETES_IMAGE_CONNECTOR : var.kubernetes_override_image_connector
        }
      )

      # Docker Image Regisry Details
      DOCKER_REGISTRY_ID : var.container_registry_connector_id

      SOURCE_REPO_URL : "https://git.harness.io/AM8HCbDiTXGQNrTIhNl7qQ/hcr/hsf/harness-delegate-setup.git"
      SOURCE_BRANCH : "main"
      TARGET_REPO_URL : harness_platform_repo.repository.0.git_url
      TARGET_REPO_TOKEN : var.existing_harness_platform_key_ref

      TAGS : yamlencode(local.common_tags)
    }
  )
  tags = local.common_tags_tuple
}
