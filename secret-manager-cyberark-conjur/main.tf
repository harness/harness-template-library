data "harness_platform_organization" "template" {
  count      = var.organization_id == null ? 0 : 1
  identifier = var.organization_id
}

data "harness_platform_project" "template" {
  count      = var.project_id == null ? 0 : 1
  identifier = var.project_id
  org_id     = data.harness_platform_organization.template[0].id
}

resource "harness_platform_template" "cyberark_conjur" {
  org_id     = local.organization_id
  project_id = local.project_id
  identifier = local.fmt_identifier
  name       = var.template_name
  version    = var.template_version
  is_stable  = true
  template_yaml = templatefile(
    "${path.module}/templates/secret_managers/cyberark-conjur.yaml",
    {
      TEMPLATE_IDENTIFIER : local.fmt_identifier
      TEMPLATE_NAME : var.template_name
      ORGANIZATION_ID : local.organization_id == null ? "" : local.organization_id
      PROJECT_ID : local.project_id == null ? "" : local.project_id
      VERSION_LABEL : var.template_version
      TAGS : yamlencode(local.common_tags)
    }
  )
}
