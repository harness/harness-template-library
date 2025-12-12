locals {

  environments_files_path = "${local.source_directory}/environments"

  environment_files = fileset("${local.environments_files_path}/", "*.yaml")


  environments = flatten([
    for environment_file in local.environment_files : [
      merge(
        yamldecode(file("${local.environments_files_path}/${environment_file}")),
        {
          identifier = replace(replace(replace(environment_file, ".yaml", ""), " ", "_"), "-", "_")
          name       = replace(replace(replace(environment_file, ".yaml", ""), "-", "_"), "_", " ")
        }
      )
    ]
  ])

  environment_overrides = flatten([
    for override in local.environments : [
      override
    ] if lookup(override, "yaml", {}) != {}
  ])
}

resource "harness_platform_environment" "environments" {
  for_each = {
    for environment in local.environments : environment.name => environment
  }

  identifier = each.value.identifier

  name        = each.value.name
  type        = lookup(each.value, "type", "PreProduction")
  description = lookup(each.value, "description", "Harness Environment managed by Solutions Factory")
  tags = flatten([
    [for k, v in lookup(each.value, "tags", {}) : "${k}:${v}"],
    local.common_tags_tuple
  ])

}

resource "harness_platform_overrides" "example" {
  for_each = {
    for environment in local.environment_overrides : environment.identifier => environment
  }
  env_id = "account.dev"
  type   = "ENV_GLOBAL_OVERRIDE"
  yaml   = lookup(each.value, "yaml", {}) != {} ? replace(yamlencode(each.value.yaml), "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/", "$1$2:") : ""
  # yaml   = lookup(each.value, "yaml", {}) != {} ? yamlencode(each.value.yaml) : ""
}
