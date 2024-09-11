locals {

  organization_url = join("/",
    [
      trimsuffix(replace(var.harness_platform_url, "gateway", "ng"), "/"),
      "account",
      var.harness_platform_account,
      "all/orgs",
      data.harness_platform_organization.selected.id,
      "projects"
    ]
  )
}

output "organization_identifier" {
  description = "Organization Identifier"
  value       = data.harness_platform_organization.selected.identifier
}

output "organization_url" {
  value = local.organization_url
}
