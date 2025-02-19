locals {
  required_tags = {
    required_for : "buildfarm_container_registry"
  }

  common_tags = merge(
    var.tags,
    local.required_tags
  )

  # Harness Tags are read into Terraform as a standard Map entry but need to be converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  self_hosted_only_auth_types   = ["delegate", "certificate", "secret"]
  harness_cloud_only_auth_types = setsubtract(local.self_hosted_only_auth_types, ["delegate"])

  managed_identity_type = var.identity_type == "user" ? "UserAssignedManagedIdentity" : "SystemAssignedManagedIdentity"

  credential_variables = {
    application_id : var.application_id
    tenant_id : var.tenant_id
  }

  harness_cloud_ready = (
    var.support_harness_cloud && contains(local.harness_cloud_only_auth_types, lower(var.authentication_type_harness_cloud)) != true
    ?
    "[Invalid] Chosen authentication type (${var.authentication_type_harness_cloud}) not supported for Harness Cloud connectors. Supported Types - ${join(",", local.harness_cloud_only_auth_types)}"
    :
    null
  )

  manual_creds_ready = (
    lower(var.authentication_type_self_hosted) != "delegate" || lower(var.authentication_type_harness_cloud) != "delegate"
    ?
    join("\n", compact(flatten([
      for check_name, check_var in local.credential_variables :
      check_var == null
      ?
      "[Invalid] Missing value for variable '${check_name}' which is required for the chosen auth type ('oidc')"
      :
      null
    ])))
    :
    null
  )

  manual_creds_type_verification = (
    var.support_harness_cloud && var.support_harness_cloud
    ?
    lower(var.authentication_type_self_hosted) != "delegate" && lower(var.authentication_type_self_hosted) != lower(var.authentication_type_harness_cloud)
    ?
    "[Invalid] When chosing a Secret or Certificate Type, both Self-Hosted AuthMethod (${var.authentication_type_self_hosted}) and Harness Cloud AuthMethod (${var.authentication_type_harness_cloud}) must match"
    :
    null
    :
    null
  )

  # Delegate selector validation (required for self-hosted connectors)
  delegate_selector_ready = (
    var.support_self_hosted && var.delegate_selectors == []
    ? "[Invalid] Missing value for 'delegate_selectors', required for self-hosted connectors."
    : null
  )

  # IAM Role validation (required for UserAssignedManagedIdentity in InheritFromDelegate)
  user_assigned_ready = (
    var.support_harness_cloud && lower(var.authentication_type_self_hosted) == "delegate"
    ?
    lower(var.identity_type) == "user" && var.user_assigned_client_id == null
    ?
    "[Invalid] Missing value for 'user_assigned_client_id', required for UserAssignedManagedIdentity in InheritFromDelegate authentication."
    :
    null
    :
    null
  )

  # Aggregate self-hosted validation errors
  self_hosted_verification_message = compact([
    local.delegate_selector_ready,
    local.manual_creds_ready,
    local.manual_creds_type_verification,
    local.user_assigned_ready
  ])

  # Aggregate cloud validation errors
  cloud_verification_message = compact([
    local.harness_cloud_ready,
    local.manual_creds_ready,
    local.manual_creds_type_verification
  ])

  # Final readiness checks for self-hosted and cloud connectors
  resource_self_hosted_ready = (
    var.support_self_hosted && length(local.self_hosted_verification_message) > 0
    ? join("\n", local.self_hosted_verification_message)
    : ""
  )

  resource_cloud_ready = (
    var.support_harness_cloud && length(local.cloud_verification_message) > 0
    ? join("\n", local.cloud_verification_message)
    : ""
  )
}
