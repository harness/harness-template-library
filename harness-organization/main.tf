resource "harness_platform_organization" "selected" {
  identifier  = local.fmt_identifier
  name        = var.organization_name
  description = var.organization_description

  tags = local.common_tags_tuple
}
# When creating a new Project, there is a potential race-condition
# as the project comes up.  This resource will introduce
# a slight delay in further execution to wait for the resources to
# complete.
resource "time_sleep" "org_setup" {
  depends_on = [
    harness_platform_organization.selected
  ]

  create_duration = "15s"
}

data "harness_platform_organization" "selected" {
  identifier = harness_platform_organization.selected.id
}

data "harness_platform_permissions" "current" {}
