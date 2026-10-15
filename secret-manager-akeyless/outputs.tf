locals {
  step_template_url = join("",
    [
      trimsuffix(replace(var.harness_platform_url, "gateway", "ng"), "/"),
      "/account/",
      var.harness_platform_account,
      "/all",
      var.organization_id != null ? "/orgs/${var.organization_id}" : "",
      var.project_id != null ? "/projects/${var.project_id}" : "",
      "/settings/templates/",
      replace(replace(var.template_name, " ", "_"), "-", "_"),
      "/template-studio/SecretManager/?versionLabel=",
      var.template_version
    ]
  )
}

output "template_id" {
  value       = harness_platform_template.akeyless.id
  description = "Template ID"
}

output "step_template_url" {
  value       = local.step_template_url
  description = "Link to the created Step Template in the Template Studio"
}
