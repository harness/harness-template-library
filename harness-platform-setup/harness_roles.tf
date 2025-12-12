locals {
  roles_files_path = "${local.source_directory}/roles"

  role_files = fileset("${local.roles_files_path}/", "*.yaml")


  roles = flatten([
    for role_file in local.role_files : [
      merge(
        yamldecode(file("${local.roles_files_path}/${role_file}")),
        {
          identifier = replace(replace(replace(role_file, ".yaml", ""), " ", "_"), "-", "_")
          name       = replace(replace(replace(role_file, ".yaml", ""), "-", "_"), "_", " ")

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
  account_permission_identifiers = sort(compact(flatten([
    for permission in data.harness_platform_permissions.current.permissions : [
      permission.identifier
    ] if contains(local.permission_statuses, permission.status) && contains(permission.allowed_scope_levels, "account")
  ])))

  # This object will contain keys based on the role name and the value of invalid permissions
  invalid_account_permissions = merge({
    for role in local.roles :
    (role.identifier) => flatten([
      for permission in role.permissions : [
        permission
      ] if !contains(local.account_permission_identifiers, permission)
    ])
  })
}

resource "harness_platform_roles" "role" {
  for_each = {
    for role in local.roles : role.identifier => role
  }
  # Lifecycle hook to prevent errors in planning due to invalid permission sets
  lifecycle {
    precondition {
      condition     = length(local.invalid_account_permissions[each.key]) == 0
      error_message = <<EOF
      [Invalid] The following permissions are invalid for this role - ${each.key}.
      - ${join("\n      - ", local.invalid_account_permissions[each.key])}
      EOF
    }
  }

  identifier = each.value.identifier

  name                 = each.value.name
  allowed_scope_levels = ["account"]

  # [Optional] (Set of String) List of the permission identifiers
  #
  # Note: Full list of current and valid permissions can be found here
  # https://app.harness.io/gateway/authz/api/permissions
  # API Docs - https://apidocs.harness.io/tag/Permissions#operation/getPermissionList
  permissions = each.value.permissions

  tags = local.common_tags_tuple

}
