data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

data "harness_platform_default_images" "default" {
  for_each = toset(var.modules)
  kind     = each.key
}

# One pipeline per module, seeded with the currently configured default images
resource "harness_platform_pipeline" "default_images_manual_update" {
  for_each = toset(var.modules)

  org_id      = data.harness_platform_organization.selected.id
  project_id  = data.harness_platform_project.selected.id
  identifier  = replace("${each.key}_default_images_manual_update", "-", "_")
  name        = "${upper(each.key)} Default Images Manual Update"
  description = "Manually set default execution images for ${upper(each.key)}"
  tags        = local.common_tags_tuple

  yaml = templatefile(
    "${path.module}/templates/pipelines/pipe_default_images_manual_update.yaml.tpl",
    {
      # Pipeline Setup Details
      PIPELINE_IDENTIFIER : replace("${each.key}_default_images_manual_update", "-", "_")
      PIPELINE_NAME : "${upper(each.key)} Default Images Manual Update"
      ORGANIZATION_ID : data.harness_platform_organization.selected.id
      PROJECT_ID : data.harness_platform_project.selected.id
      DESCRIPTION : "Manually set default execution images for ${upper(each.key)}"

      # Pipeline Inputs
      SECRET_ID : var.harness_api_key_secret_ref
      MODULE : each.key == "iacm" ? "iacm-manager" : each.key
      DEFAULT_IMAGES : local.default_images[each.key]
      # Field/value pairs used by the "update default" http step
      SET_IMAGES : replace(replace(jsonencode([for image, value in local.default_images[each.key] : { "field" : image, "value" : "<+pipeline.variables.${image}>" }]), "\\u003c", "<"), "\\u003e", ">")
      # Field-only list used by the "reset default" http step
      RESET_IMAGES : replace(replace(jsonencode([for image, _ in local.default_images[each.key] : { "field" : image }]), "\\u003c", "<"), "\\u003e", ">")

      TAGS : yamlencode(local.common_tags)
    }
  )
}
