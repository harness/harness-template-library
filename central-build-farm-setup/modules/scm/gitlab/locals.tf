locals {
  # Required tags for the resource
  required_tags = {
    required_for : "buildfarm_scm"
  }

  # Combine required tags with user-provided tags
  common_tags = merge(
    var.tags,
    local.required_tags
  )

  # Convert tags into a key:value tuple
  common_tags_tuple = [for k, v in local.common_tags : "${k}:${v}"]

  # Define valid authentication types for GitLab
  valid_authentication_types = ["http", "ssh"]

  # Validation for authentication type
  auth_type_valid = (
    contains(local.valid_authentication_types, var.source_code_manager_auth_type)
    ? null
    : "[Invalid] Chosen authentication type '${var.source_code_manager_auth_type}' is not supported. Valid types: ${join(", ", local.valid_authentication_types)}"
  )

  # Validation for SCM URL
  scm_url_valid = (
    length(var.source_code_manager_url) > 0
    ? null
    : "[Invalid] Missing value for 'source_code_manager_url', required for GitLab connector."
  )

  # Validation for Credentials based on Authentication Type
  credentials_valid = (
    var.source_code_manager_auth_type == "http"
    ?
    (
      var.scm_username == null || var.scm_password == null
      ? "[Invalid] 'username' and 'password_ref' must be provided for HTTP authentication."
      : null
    )
    : var.source_code_manager_auth_type == "ssh"
    ?
    (
      var.scm_password == null
      ? "[Invalid] 'ssh_key_ref' must be provided for SSH authentication."
      : null
    )
    : null
  )

  # Validation for Delegate Selectors
  delegate_selector_ready = (
    var.delegate_selectors == []
    ? "[Invalid] Missing value for 'delegate_selectors', required for self-hosted connectors."
    : null
  )

  # Aggregate self-hosted validation errors
  self_hosted_verification_message = compact([
    local.auth_type_valid,
    local.scm_url_valid,
    local.credentials_valid,
    local.delegate_selector_ready
  ])

  # Aggregate cloud validation errors
  cloud_verification_message = compact([
    local.auth_type_valid,
    local.scm_url_valid,
    local.credentials_valid
  ])

  # Final readiness check for self-hosted and cloud connectors
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
