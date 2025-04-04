resource "harness_platform_variables" "test" {
  identifier = "identifier"
  name       = "name"
  org_id     = data.harness_platform_organization.selected.id
  project_id = data.harness_platform_project.selected.id
  type       = "String"
  spec {
    value_type  = "FIXED"
    fixed_value = "fixedValue"
  }
}