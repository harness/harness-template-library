locals {

  project_url = join("/",
    [
      trimsuffix(replace(var.harness_platform_url, "gateway", "ng"), "/"),
      "account",
      var.harness_platform_account,
      "all/orgs",
      data.harness_platform_organization.selected.id,
      "projects",
      data.harness_platform_project.selected.id,
      "overview"
    ]
  )
}

output "organization_identifier" {
  description = "Organization Identifier"
  value       = data.harness_platform_organization.selected.identifier
}

output "project_identifier" {
  description = "Project Identifier"
  value       = data.harness_platform_project.selected.identifier
}

output "project_url" {
  value = local.project_url
}
