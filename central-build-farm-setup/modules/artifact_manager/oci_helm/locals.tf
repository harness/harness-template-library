locals {
  # Required tags for the resource
  required_tags = {
    required_for = "buildfarm_artifact_manager"
  }

  # Combine required tags with user-provided tags
  common_tags = merge(
    var.tags,
    local.required_tags
  )

  # Harness Tags are read into Terraform as a standard Map entry but needs to be
  # converted into a list of key:value entries
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  # Define valid authentication types for OCI Helm
  valid_oci_auth_types = ["UsernamePassword", "Anonymous"]

  # Validation for authentication type
  auth_type_valid = (
    contains(local.valid_oci_auth_types, var.artifact_manager_auth_type)
    ? null
    : "[Invalid] Chosen OCI authentication type '${var.artifact_manager_auth_type}' is not supported. Valid types: ${join(", ", local.valid_oci_auth_types)}"
  )

  # Validation for OCI Helm URL
  oci_url_valid = (
    length(var.artifact_manager_url) > 0
    ? null
    : "[Invalid] Missing value for 'oci_helm_url', required for OCI Helm connector."
  )

  # Validation for Username and Password if using UsernamePassword authentication
  username_password_valid = (
    var.artifact_manager_auth_type == "UsernamePassword"
    ?
    (
      var.artifact_manager_username == null || var.artifact_manager_password == null
      ? "[Invalid] 'artifact_manager_username' and 'artifact_manager_password' must be provided for UsernamePassword authentication."
      : null
    )
    : null
  )

  # Validation for Delegate Selectors
  delegate_selector_ready = (
    var.artifact_manager_delegate == []
    ? "[Invalid] Missing value for 'delegate_selectors', required for self-hosted connectors."
    : null
  )

  # Aggregate self-hosted validation errors
  self_hosted_verification_message = compact([
    local.auth_type_valid,
    local.oci_url_valid,
    local.username_password_valid,
    local.delegate_selector_ready
  ])

  # Final readiness check for self-hosted connectors
  resource_self_hosted_ready = (
    var.support_self_hosted && length(local.self_hosted_verification_message) > 0
    ? join("\n", local.self_hosted_verification_message)
    : ""
  )
}
