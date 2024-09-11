locals {
  roles_files_path = "${local.source_directory}/roles"

  role_files = fileset("${local.roles_files_path}/", "*.yaml")


  roles = flatten([
    for role_file in local.role_files : [
      merge(
        yamldecode(file("${local.roles_files_path}/${role_file}")),
        {
          name = replace(role_file, ".yaml", "")

        }
      )
    ]
  ])
}

resource "harness_platform_roles" "role" {
  for_each = {
    for role in local.roles : role.name => role
  }

  identifier = replace(replace(each.value.name, " ", "_"), "-", "_")

  name                 = each.value.name
  org_id               = data.harness_platform_organization.selected.id
  allowed_scope_levels = ["organization"]

  # [Optional] (Set of String) List of the permission identifiers
  #
  # Note: Full list of current and valid permissions can be found here
  # https://app.harness.io/gateway/authz/api/permissions
  # API Docs - https://apidocs.harness.io/tag/Permissions#operation/getPermissionList
  permissions = each.value.permissions

  tags = local.common_tags_tuple

}
