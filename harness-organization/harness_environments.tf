locals {

  environments_files_path = "${local.source_directory}/environments"

  environment_files = fileset("${local.environments_files_path}/", "*.yaml")


  environments = flatten([
    for environment_file in local.environment_files : [
      merge(
        yamldecode(file("${local.environments_files_path}/${environment_file}")),
        {
          identifier = replace(replace(replace(environment_file, ".yaml", ""), " ", "_"), "-", "_")
          name       = replace(environment_file, ".yaml", "")
        }
      )
    ]
  ])

  environments_bindings = flatten([
    for environment in local.environments : [
      for binding in lookup(environment, "role_bindings", []) : {
        identifier             = "${environment.identifier}_${lookup(binding, "role", "MISSING-ROLE-ID")}"
        environment_identifier = environment.identifier
        role                   = lookup(binding, "role", "MISSING-ROLE")
        resource_environment   = lookup(binding, "resource_environment", "MISSING-ROLE")
      }
    ]

  ])
}

resource "harness_platform_environment" "environments" {
  for_each = {
    for environment in local.environments : environment.name => environment
  }

  identifier = replace(replace(each.value.name, " ", "_"), "-", "_")

  name        = each.value.name
  org_id      = data.harness_platform_organization.selected.id
  type        = lookup(each.value, "type", "PreProduction")
  description = lookup(each.value, "description", "Harness Environment managed by Solutions Factory")
  tags = flatten([
    [for k, v in lookup(each.value, "tags", {}) : "${k}:${v}"],
    local.common_tags_tuple
  ])

  yaml = lookup(each.value, "yaml", {}) != {} ? yamlencode(each.value.yaml) : null
}
