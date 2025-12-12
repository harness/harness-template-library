locals {
  groups_files_path = "${local.source_directory}/groups"

  group_files = fileset("${local.groups_files_path}/", "*.yaml")


  all_groups = flatten([
    for group_file in local.group_files : [
      merge(
        yamldecode(file("${local.groups_files_path}/${group_file}")),
        {
          identifier = replace(replace(replace(group_file, ".yaml", ""), " ", "_"), "-", "_")
          name       = replace(replace(replace(group_file, ".yaml", ""), "-", "_"), "_", " ")
        }
      )
    ]
  ])

  groups = flatten([
    for group in local.all_groups : [
      group
    ] if !startswith(group.identifier, "_")
  ])

  existing_groups = flatten([
    for group in local.all_groups : [
      group
    ] if startswith(group.identifier, "_")
  ])

  groups_bindings = flatten([
    for group in local.all_groups : [
      for binding in lookup(group, "role_bindings", []) : {
        identifier       = "${group.identifier}_${lookup(binding, "role", "MISSING-ROLE-ID")}"
        group_identifier = group.identifier
        role             = lookup(binding, "role", "MISSING-ROLE")
        resource_group   = lookup(binding, "resource_group", "MISSING-ROLE")
      }
    ]

  ])
}

data "harness_platform_usergroup" "usergroup" {
  for_each = {
    for group in local.existing_groups : group.identifier => group
  }
  identifier = each.value.identifier
}

resource "harness_platform_usergroup" "usergroup" {
  depends_on = [harness_platform_roles.role, harness_platform_resource_group.resource_group]
  lifecycle {
    ignore_changes = [
      users,
      user_emails,
      linked_sso_id,
      linked_sso_display_name,
      linked_sso_type,
      notification_configs,
      sso_linked,
      sso_group_id,
      sso_group_name
    ]
  }
  for_each = {
    for group in local.groups : group.identifier => group
  }

  identifier = each.value.identifier

  name        = each.value.name
  description = "Harness UserGroup managed by Solutions Factory"
  user_emails = []

  externally_managed      = false
  linked_sso_id           = lookup(each.value, "linked_sso_id", null)
  linked_sso_display_name = lookup(each.value, "linked_sso_id", null)
  linked_sso_type         = lookup(each.value, "linked_sso_type", null)
  sso_linked              = lookup(each.value, "sso_group_id", null) != null ? true : false
  sso_group_id            = lookup(each.value, "sso_group_id", null)
  sso_group_name          = lookup(each.value, "sso_group_id", null)

  tags = local.common_tags_tuple
}

resource "harness_platform_role_assignments" "usergroup_bindings" {
  depends_on = [harness_platform_usergroup.usergroup]
  for_each = {
    for group in local.groups_bindings : group.identifier => group
  }

  identifier                = each.value.identifier
  resource_group_identifier = each.value.resource_group
  role_identifier           = each.value.role
  principal {
    identifier = try(
      harness_platform_usergroup.usergroup[each.value.group_identifier].id,
      data.harness_platform_usergroup.usergroup[each.value.group_identifier].id
    )
    type = "USER_GROUP"
  }
  disabled = false
  managed  = false
}
