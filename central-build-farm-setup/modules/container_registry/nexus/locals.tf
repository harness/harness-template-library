locals {
  # Required tags for the resource
  required_tags = {
    required_for : "buildfarm_container_registry"
  }

  # Combine required tags with user-provided tags
  common_tags = merge(
    var.tags,
    local.required_tags
  )

  # Convert tags into a key:value tuple
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  # Define valid Nexus versions
  valid_nexus_versions = ["3.x", "2.x"]

  # Define valid authentication types for Nexus
  valid_nexus_auth_types = ["UsernamePassword", "Anonymous"]

  # Validate the chosen authentication type
  auth_type_valid = (
    contains(local.valid_nexus_auth_types, var.authentication_type_self_hosted)
    ? null
    : "[Invalid] Chosen Nexus authentication type '${var.authentication_type_self_hosted}' is not supported. Valid types: ${join(", ", local.valid_nexus_auth_types)}"
  )

  # Validation for Nexus version
  nexus_version_valid = (
    contains(local.valid_nexus_versions, var.nexus_version)
    ? null
    : "[Invalid] Chosen Nexus version '${var.nexus_version}' is not supported. Valid versions: ${join(", ", local.valid_nexus_versions)}"
  )

  # Validate that Username and Password are provided for UsernamePassword authentication
  username_password_valid = (
    var.authentication_type_self_hosted == "UsernamePassword"
    ?
    (
      var.container_registry_username == null || var.container_registry_password == null
      ? "[Invalid] 'nexus_username' and 'nexus_password_ref' must be provided for UsernamePassword authentication."
      : null
    )
    : null
  )

  # Validate that delegate selectors are provided
  delegate_selector_ready = (
    var.delegate_selectors == []
    ? "[Invalid] Missing value for 'delegate_selectors', required for self-hosted Nexus connectors."
    : null
  )

  # Aggregate self-hosted validation errors
  self_hosted_verification_message = compact([
    local.auth_type_valid,
    local.username_password_valid,
    local.delegate_selector_ready,
    local.nexus_version_valid
  ])

  # Final readiness check for self-hosted connectors
  resource_self_hosted_ready = (
    var.support_self_hosted && length(local.self_hosted_verification_message) > 0
    ? join("\n", local.self_hosted_verification_message)
    : ""
  )
}
