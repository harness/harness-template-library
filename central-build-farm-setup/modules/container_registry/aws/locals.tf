locals {
  required_tags = {
    required_for : "buildfarm_container_registry"
  }

  common_tags = merge(
    var.tags,
    local.required_tags
  )

  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  self_hosted_only_auth_types   = ["manual", "delegate", "irsa", "oidc"]
  harness_cloud_only_auth_types = setsubtract(local.self_hosted_only_auth_types, ["delegate", "irsa"])
  supports_cross_account_access = setsubtract(local.self_hosted_only_auth_types, local.harness_cloud_only_auth_types)

  cross_account_access = (
    contains(local.supports_cross_account_access, var.authentication_type_self_hosted) && var.cross_account_role_arn != null
    ?
    true
    :
    false
  )

  delegate_selector_ready = (
    var.support_self_hosted
    ?
    var.delegate_selectors == []
    ?
    "[Invalid] Missing value for variable 'delegate_selectors' which is required for Self-hosted connectors"
    :
    null
    :
    null
  )

  iam_role_arn_ready = (
    var.authentication_type_self_hosted == "oidc" || var.authentication_type_harness_cloud == "oidc"
    ?
    var.iam_role_arn == null
    ?
    "[Invalid] Missing value for variable 'iam_role_arn' which is required for the chosen auth type ('oidc')"
    :
    null
    :
    null
  )

  harness_cloud_ready = (
    var.support_harness_cloud
    ?
    contains(local.harness_cloud_only_auth_types, var.authentication_type_harness_cloud) != true
    ?
    "[Invalid] Chosen authentication type (${var.authentication_type_harness_cloud}) not supported for Harness Cloud connectors. Supported Types - ${join(",", local.harness_cloud_only_auth_types)}"
    :
    null
    :
    null
  )

  self_hosted_verification_message   = compact([local.delegate_selector_ready, local.iam_role_arn_ready])
  harness_cloud_verification_message = compact([local.harness_cloud_ready, local.iam_role_arn_ready])

  resource_self_hosted_ready = (
    var.support_self_hosted
    ?
    length(local.self_hosted_verification_message) > 0
    ?
    join("\n", local.self_hosted_verification_message)
    :
    ""
    :
    ""
  )

  resource_cloud_ready = (
    var.support_harness_cloud
    ?
    length(local.harness_cloud_verification_message) > 0
    ?
    join("\n", local.harness_cloud_verification_message)
    :
    ""
    :
    ""
  )
}
