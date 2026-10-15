locals {
  required_tags = {
    created_by : "Terraform"
    harnessSolutionsFactory : "true"
    managedResource : "true"
  }

  common_tags = merge(
    var.tags,
    local.required_tags
  )

  ####################
  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries when declared as a parameter for
  # the resource.
  ####################
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  # Shared template interpolation values for org/project scoping
  common_template_vars = {
    ORGANIZATION_ID = var.organization_id != null ? data.harness_platform_organization.this[0].id : null
    PROJECT_ID      = var.project_id != null ? data.harness_platform_project.this[0].id : null
  }
}
