# Create shared manifests for baseline autostopping resource
data "harness_platform_organization" "template" {
  count      = var.template_organization_id == null ? 0 : 1
  identifier = var.template_organization_id
}

data "harness_platform_project" "template" {
  count      = var.template_project_id == null ? 0 : 1
  identifier = var.template_project_id
  org_id     = data.harness_platform_organization.template[0].id
}

resource "harness_platform_file_store_folder" "root" {
  org_id            = local.template_organization_id
  project_id        = local.template_project_id
  identifier        = local.fmt_template_name
  name              = var.template_name
  parent_identifier = "Root"
  tags              = local.common_tags_tuple
}

resource "harness_platform_file_store_file" "manifest" {
  org_id            = local.template_organization_id
  project_id        = local.template_project_id
  identifier        = "${local.fmt_template_name}_autostoppingyaml"
  name              = "autostopping.yaml"
  parent_identifier = harness_platform_file_store_folder.root.id
  file_content_path = "templates/files/manifest.yaml"
  mime_type         = "application/x-yaml"
  file_usage        = "MANIFEST_FILE"
  tags              = local.common_tags_tuple
}

resource "harness_platform_file_store_file" "values" {
  org_id            = local.template_organization_id
  project_id        = local.template_project_id
  identifier        = "${local.fmt_template_name}_valuesyaml"
  name              = "values.yaml"
  parent_identifier = harness_platform_file_store_folder.root.id
  file_content_path = "templates/files/values.yaml"
  mime_type         = "application/x-yaml"
  file_usage        = "MANIFEST_FILE"
  tags              = local.common_tags_tuple
}

# Create a step template to apply the shared manifest
resource "harness_platform_template" "create_autostopping_resource" {
  org_id     = local.template_organization_id
  project_id = local.template_project_id
  identifier = local.fmt_template_name
  name       = var.template_name
  version    = var.template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/steps/autostop_k8s_ingress.yaml",
    {
      # Pipeline Setup Details
      TEMPLATE_IDENTIFIER : local.fmt_template_name
      TEMPLATE_NAME : var.template_name
      ORGANIZATION_ID : var.template_organization_id == null ? "" : data.harness_platform_organization.template[0].id
      PROJECT_ID : var.template_project_id == null ? "" : data.harness_platform_project.template[0].id
      VERSION_LABEL : var.template_version

      TAGS : yamlencode(local.common_tags)

      MANIFEST_PATH : "${harness_platform_file_store_folder.root.name}/${harness_platform_file_store_file.manifest.name}"
      VALUES_PATH : "${harness_platform_file_store_folder.root.name}/${harness_platform_file_store_file.values.name}"
    }
  )
}
