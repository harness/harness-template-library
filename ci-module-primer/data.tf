# Data sources for template creation  organization and project (optional)
data "harness_platform_organization" "this" {
  count      = var.organization_id == null ? 0 : 1
  identifier = var.organization_id
}

data "harness_platform_project" "this" {
  count      = var.project_id == null ? 0 : 1
  identifier = var.project_id
  org_id     = data.harness_platform_organization.this[0].id
}
