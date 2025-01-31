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

  # Valid authentication types for Azure connectors
  azure_auth_types = ["ManagedIdentity", "Certificate", "Secret"]

  # Valid authentication methods for `ManualConfig`
  azure_auth_methods = ["Secret", "Certificate"]

  # Validation for self-hosted connectors
  self_hosted_auth_type_valid = (
    contains(local.azure_auth_types, var.authentication_type_self_hosted)
    ? null
    : "[Invalid] Chosen authentication type '${var.authentication_type_self_hosted}' is not supported for self-hosted connectors. Valid types: ${join(", ", local.azure_auth_types)}"
  )

  self_hosted_auth_method_valid = (
    var.authentication_type_self_hosted == "ManualConfig"
    ?
    contains(local.azure_auth_methods, var.authentication_type_harness_cloud)
    ? null
    : "[Invalid] Chosen authentication method '${var.authentication_type_harness_cloud}' is not supported for ManualConfig. Valid methods: ${join(", ", local.azure_auth_methods)}"
    :
    null
  )

  # Validation for cloud connectors
  cloud_auth_type_valid = (
    contains(local.azure_auth_types, var.authentication_type_harness_cloud)
    ? null
    : "[Invalid] Chosen authentication type '${var.authentication_type_harness_cloud}' is not supported for cloud connectors. Valid types: ${join(", ", local.azure_auth_types)}"
  )

  cloud_auth_method_valid = (
    var.authentication_type_harness_cloud == "ManualConfig"
    ?
    contains(local.azure_auth_methods, var.authentication_type_harness_cloud)
    ? null
    : "[Invalid] Chosen authentication method '${var.authentication_type_harness_cloud}' is not supported for ManualConfig. Valid methods: ${join(", ", local.azure_auth_methods)}"
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
    (var.authentication_type_self_hosted == "InheritFromDelegate" || var.authentication_type_harness_cloud == "InheritFromDelegate") &&
    var.identity_type == "UserAssignedManagedIdentity" &&
    var.user_assigned_client_id == null
    ? "[Invalid] Missing value for 'user_assigned_client_id', required for UserAssignedManagedIdentity in InheritFromDelegate authentication."
    : null
  )

  # Aggregate self-hosted validation errors
  self_hosted_verification_message = compact([
    local.self_hosted_auth_type_valid,
    local.self_hosted_auth_method_valid,
    local.delegate_selector_ready,
    local.user_assigned_ready
  ])

  # Aggregate cloud validation errors
  cloud_verification_message = compact([
    local.cloud_auth_type_valid,
    local.cloud_auth_method_valid,
    local.user_assigned_ready
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
