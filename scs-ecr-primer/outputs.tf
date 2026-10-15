# Template Outputs
output "step_group_templates" {
  description = "Information about the created SCS ECR step group templates"
  value = {
    ci = {
      id      = harness_platform_template.stg_scs_ecr_ci_v1.id
      version = harness_platform_template.stg_scs_ecr_ci_v1.version
    }
    cd = {
      id      = harness_platform_template.stg_scs_ecr_cd_v1.id
      version = harness_platform_template.stg_scs_ecr_cd_v1.version
    }
  }
}

# Template Organization and Project (if provided)
output "template_organization_info" {
  description = "Template organization information (if provided)"
  value = var.organization_id != null ? {
    id = data.harness_platform_organization.this[0].id
  } : null
}

output "template_project_info" {
  description = "Template project information (if provided)"
  value = var.project_id != null ? {
    id = data.harness_platform_project.this[0].id
  } : null
}
