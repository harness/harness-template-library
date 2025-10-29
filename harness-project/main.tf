
data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

resource "harness_platform_project" "selected" {
  identifier  = local.fmt_identifier
  name        = var.project_name
  org_id      = data.harness_platform_organization.selected.id
  description = var.project_description

  tags = local.common_tags_tuple
}
# When creating a new Project, there is a potential race-condition
# as the project comes up.  This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "project_setup" {
  depends_on = [
    harness_platform_project.selected
  ]

  create_duration = "15s"
}

data "harness_platform_project" "selected" {
  depends_on = [time_sleep.project_setup]
  identifier = harness_platform_project.selected.id
  org_id     = data.harness_platform_organization.selected.id
}

data "harness_platform_permissions" "current" {}
