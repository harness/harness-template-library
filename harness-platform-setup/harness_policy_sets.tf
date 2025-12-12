locals {
  policy_sets_files_path = "${local.source_directory}/policy_sets"

  policy_sets_files = fileset("${local.policy_sets_files_path}/", "*.yaml")

  policy_sets = flatten([
    for policy_file in local.policy_sets_files : [
      merge(
        yamldecode(file("${local.policy_sets_files_path}/${policy_file}")),
        {
          identifier = replace(replace(replace(policy_file, ".yaml", ""), " ", "_"), "-", "_")
          name       = replace(replace(replace(policy_file, ".yaml", ""), "-", "_"), "_", " ")
        }
      )
    ]
  ])
}
resource "harness_platform_policyset" "policy_sets" {
  depends_on = [harness_platform_policy.policies]
  for_each = {
    for policy_set in local.policy_sets : policy_set.identifier => policy_set
  }
  # Lifecycle hook to prevent errors in planning due to missing variables
  lifecycle {
    precondition {
      condition = alltrue([
        contains(keys(each.value), "identifier"),
        contains(keys(each.value), "name"),
        contains(keys(each.value), "action"),
        contains(keys(each.value), "type"),
        contains(["onrun", "onsave", "onstep"], lookup(each.value, "action", "missing-action"))
      ])
      error_message = <<EOF
      [Invalid] The following PolicySet (${each.key}) is invalid and missing one or more manadatory keys.
      - identifier
      - name
      - action
      - type

      Supported Action types are (depends on Policy Set type):
      - onrun
      - onsave
      - onstep
      EOF
    }
  }
  identifier = each.value.identifier
  name       = each.value.name
  action     = each.value.action
  type       = each.value.type
  enabled    = lookup(each.value, "enabled", true)

  dynamic "policy_references" {
    for_each = lookup(each.value, "policies", [])
    content {
      identifier = policy_references.value["identifier"]
      severity   = lookup(policy_references.value, "severity", "error")
    }
  }

  tags = flatten([
    [for k, v in lookup(each.value, "tags", {}) : "${k}:${v}"],
    local.common_tags_tuple
  ])
}
