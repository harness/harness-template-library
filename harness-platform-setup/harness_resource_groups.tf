locals {
  resource_groups_files_path = "${local.source_directory}/resource_groups"

  resource_group_files = fileset("${local.resource_groups_files_path}/", "*.yaml")


  resource_groups = flatten([
    for resource_group_file in local.resource_group_files : [
      merge(
        yamldecode(file("${local.resource_groups_files_path}/${resource_group_file}")),
        {
          identifier = replace(replace(replace(resource_group_file, ".yaml", ""), " ", "_"), "-", "_")
          name       = replace(replace(replace(resource_group_file, ".yaml", ""), "-", "_"), "_", " ")
        }
      )
    ]
  ])
}
resource "harness_platform_resource_group" "resource_group" {
  for_each = {
    for resource_group in local.resource_groups : resource_group.name => resource_group
  }

  identifier = each.value.identifier

  name        = each.value.name
  description = lookup(each.value, "description", "Harness ResourceGroup managed by Solutions Factory")
  account_id  = var.harness_platform_account

  tags = flatten([
    [for k, v in lookup(each.value, "tags", {}) : "${k}:${v}"],
    local.common_tags_tuple
  ])

  allowed_scope_levels = ["organization"]
  included_scopes {
    filter     = lookup(each.value, "include_child_scopes", false) ? "INCLUDING_CHILD_SCOPES" : "EXCLUDING_CHILD_SCOPES"
    account_id = var.harness_platform_account
  }
  resource_filter {
    include_all_resources = lookup(each.value, "resource_filters", null) != null ? false : true
    dynamic "resources" {
      for_each = lookup(each.value, "resource_filters", [])
      content {
        resource_type = lookup(resources.value, "type", null)
        # (Set of String) List of the identifiers
        identifiers = lookup(resources.value, "identifiers", null)
        dynamic "attribute_filter" {
          for_each = lookup(resources.value, "filters", [])
          content {
            # (String) Name of the attribute
            attribute_name = lookup(attribute_filter.value, "name", null)
            # (Set of String) Value of the attributes
            attribute_values = flatten([lookup(attribute_filter.value, "values", [])])
          }
        }
      }
    }
  }
}
