resource "harness_platform_template" "stg_Build_and_Scan_Container_Image" {
  identifier = "stg_Build_and_Scan_Container_Image"
  name       = "Build and Scan Container Image"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  version    = "v1"
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_Build_and_Scan_${lower(var.container_registry_type)}_Image.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_Build_and_Scan_Container_Image"
      TEMPLATE_NAME : "Build and Scan Container Image"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      HARNESS_CONTAINER_REGISTRY : templatefile(
        "${path.module}/templates/steps/stp_${lower(var.container_registry_type)}_build.yaml",
        {
          BUILD_TAG : "<+stepGroup.variables.CACHE_TARGET_TAG>"
          BUILD_DOCKERFILE : "<+stepGroup.variables.BUILD_DOCKERFILE>"
          BUILD_CONTEXT : "<+stepGroup.variables.BUILD_CONTEXT>"
          BUILD_ARGS : "<+stepGroup.variables.BUILD_TARGET_ARGS>"
          USE_BUILD_CACHING : false
          USE_REMOTE_CACHE_REPO : var.kubernetes_connector != "skipped" ? true : false
          USE_KANIKO_VARS : var.kubernetes_connector != "skipped" ? true : false
          BUILD_OPTIMIZE : true
          BUILD_MEM : "<+stage.variables.BUILD_CONTEXT_MEM>"
        }
      )
      HARNESS_STO_SCANNER : templatefile(
        "${path.module}/templates/steps/stp_${lower(var.sto_scanner_type)}_scan.yaml",
        {
          USE_HARNESS_CLOUD : var.kubernetes_connector == "skipped" ? true : false
        }
      )
      TAGS : yamlencode(merge(
        { buildenv : "HarnessCloud" },
        local.common_tags
      ))
    }
  )
  tags = flatten([
    ["buildenv:HarnessCloud"],
    local.common_tags_tuple
  ])
}

resource "harness_platform_template" "stg_Publish_Scanned_and_Cached_Container_Image" {
  identifier = "stg_Publish_Scanned_and_Cached_Container_Image"
  name       = "Publish Scanned and Cached Container Image"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  version    = "v1"
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_Publish_Scanned_and_Cached_${lower(var.container_registry_type)}_Image.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_Publish_Scanned_and_Cached_Container_Image"
      TEMPLATE_NAME : "Publish Scanned and Cached Container Image"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      GENERATE_LOCAL_DOCKERFILE : true
      HARNESS_CONTAINER_REGISTRY : templatefile(
        "${path.module}/templates/steps/stp_${lower(var.container_registry_type)}_build.yaml",
        {
          BUILD_TAG : "<+stepGroup.variables.BUILD_TARGET_TAG>"
          BUILD_DOCKERFILE : "Dockerfile"
          USE_BUILD_CACHING : var.kubernetes_connector != "skipped" ? false : true
          USE_REMOTE_CACHE_REPO : var.kubernetes_connector != "skipped" ? true : false
          BUILD_OPTIMIZE : true
          BUILD_CONTEXT : null
          BUILD_ARGS : null
          BUILD_MEM : null
          USE_KANIKO_VARS : false
        }
      )
      CACHE_TARGET_TAG : true
      BUILD_TARGET_ARGS : false
      BUILD_DOCKERFILE : false
      BUILD_CONTEXT : false
      TAGS : yamlencode(merge(
        { "buildenv" : "HarnessCloud" },
        local.common_tags
      ))
    }
  )
  tags = flatten([
    ["buildenv:HarnessCloud"],
    local.common_tags_tuple
  ])
}

resource "harness_platform_template" "stg_Publish_Container_Image" {
  identifier = "stg_Publish_Container_Image"
  name       = "Publish Container Image"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  version    = "v1"
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/step_groups/stg_Publish_Scanned_and_Cached_${lower(var.container_registry_type)}_Image.yaml",
    {
      TEMPLATE_IDENTIFIER : "stg_Publish_Container_Image"
      TEMPLATE_NAME : "Publish Container Image"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      KUBERNETES_CONNECTOR : var.kubernetes_connector
      GENERATE_LOCAL_DOCKERFILE : false
      HARNESS_CONTAINER_REGISTRY : templatefile(
        "${path.module}/templates/steps/stp_${lower(var.container_registry_type)}_build.yaml",
        {
          BUILD_TAG : "<+stepGroup.variables.BUILD_TARGET_TAG>"
          BUILD_DOCKERFILE : "<+stepGroup.variables.BUILD_DOCKERFILE>"
          BUILD_CONTEXT : "<+stepGroup.variables.BUILD_CONTEXT>"
          BUILD_ARGS : "<+stepGroup.variables.BUILD_TARGET_ARGS>"
          USE_BUILD_CACHING : var.kubernetes_connector != "skipped" ? false : true
          USE_REMOTE_CACHE_REPO : var.kubernetes_connector != "skipped" ? true : false
          BUILD_OPTIMIZE : true
          BUILD_MEM : "<+stage.variables.BUILD_CONTEXT_MEM>"
          USE_KANIKO_VARS : false
        }
      )
      CACHE_TARGET_TAG : false
      BUILD_TARGET_ARGS : true
      BUILD_DOCKERFILE : true
      BUILD_CONTEXT : true
      TAGS : yamlencode(merge(
        { "buildenv" : "HarnessCloud" },
        local.common_tags
      ))
    }
  )
  tags = flatten([
    ["buildenv:HarnessCloud"],
    local.common_tags_tuple
  ])
}

resource "time_sleep" "stg_template_setup" {
  depends_on = [
    harness_platform_template.stg_Build_and_Scan_Container_Image,
    harness_platform_template.stg_Publish_Scanned_and_Cached_Container_Image
  ]

  destroy_duration = "15s"
}
