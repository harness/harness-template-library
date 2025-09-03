# Template Outputs
output "step_group_templates" {
  description = "Information about the created step group templates"
  value = {
    build_and_scan_container_image = {
      id      = harness_platform_template.stg_build_and_scan_container_image_v1.id
      version = harness_platform_template.stg_build_and_scan_container_image_v1.version
    }
    code_smells_and_linting = {
      id      = var.include_security_testing ? harness_platform_template.stg_code_smells_and_linting_v1[0].id : "skipped"
      version = var.include_security_testing ? harness_platform_template.stg_code_smells_and_linting_v1[0].version : "skipped"
    }
    supply_chain_security = {
      id      = var.include_supply_chain_security ? harness_platform_template.stg_supply_chain_security_v1[0].id : "skipped"
      version = var.include_supply_chain_security ? harness_platform_template.stg_supply_chain_security_v1[0].version : "skipped"
    }
  }
}

output "stage_template" {
  description = "Information about the created CI stage template"
  value = {
    id      = harness_platform_template.sta_ci_stage_v1.id
    version = harness_platform_template.sta_ci_stage_v1.version
  }
}

# Template Organization and Project (if different)
output "template_organization_info" {
  description = "Template organization information (if provided )"
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
