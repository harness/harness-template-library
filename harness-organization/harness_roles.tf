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

  # Valid list of allowed permission statuses
  permission_statuses = [
    "ACTIVE",
    "EXPERIMENTAL"
  ]

  # Generate Local list of all permissions in this scope
  organization_permission_identifiers = sort(compact(flatten([
    for permission in data.harness_platform_permissions.current.permissions : [
      permission.identifier
    ] if contains(local.permission_statuses, permission.status) && contains(permission.allowed_scope_levels, "organization")
  ])))

  # This object will contain keys based on the role name and the value of invalid permissions
  invalid_organization_permissions = merge({
    for role in local.roles :
    (role.name) => flatten([
      for permission in role.permissions : [
        permission
      ] if !contains(local.organization_permission_identifiers, permission)
    ])
  })
}

resource "harness_platform_roles" "role" {
  for_each = {
    for role in local.roles : role.name => role
  }
  # Lifecycle hook to prevent errors in planning due to invalid permission sets
  lifecycle {
    precondition {
      condition     = length(local.invalid_organization_permissions[each.key]) == 0
      error_message = <<EOF
      [Invalid] The following permissions are invalid for this role - ${each.key}.
      - ${join("\n      - ", local.invalid_organization_permissions[each.key])}
      EOF
    }
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
