data "harness_platform_organization" "selected" {
  identifier = var.organization_id
}

data "harness_platform_project" "selected" {
  identifier = var.project_id
  org_id     = data.harness_platform_organization.selected.id
}

data "harness_platform_template" "selected" {
  # lifecycle {
  #   precondition {
  #     condition     = local.template_hierarchy != "invalid"
  #     error_message = "When providing the 'template_project_id' then you must also provide 'template_organization_id'"
  #   }
  # }
  identifier = "CI_GoldenStandard_Container_Template"
  # org_id     = var.template_organization_id
  # project_id = var.template_project_id
}
