# Variables
variable "authentication_type_self_hosted" {
  type        = string
  description = "Authentication method for self-hosted builds. Options: Secret, Certificate, Delegate"
  default     = "secret"

  validation {
    condition = (
      contains(["secret", "certificate", "delegate"], lower(var.authentication_type_self_hosted))
    )
    error_message = <<EOF
        Validation of Self-Hosted Authentication Type Failed.
            * Must be one of the following:
            - secret
            - certificate
            - delegate
        EOF
  }
}

variable "authentication_type_harness_cloud" {
  type        = string
  description = "Authentication method for cloud builds. Options: Secret, Certificate"
  default     = "secret"

  validation {
    condition = (
      contains(["secret", "certificate"], lower(var.authentication_type_harness_cloud))
    )
    error_message = <<EOF
        Validation of Harness Cloud Authentication Type Failed.
            * Must be one of the following:
            - secret
            - certificate
        EOF
  }
}

variable "identity_type" {
  type        = string
  description = "Identity type for ManagedIdentity: user or system"
  default     = "system"

  validation {
    condition = (
      contains(["user", "system"], lower(var.identity_type))
    )
    error_message = <<EOF
        Validation of Managed Identity Type Failed.
            * Must be one of the following:
            - user
            - system
        EOF
  }
}

variable "application_id" {
  type        = string
  description = "Azure application ID for authentication"
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID for authentication"
  default     = null
}

variable "container_registry_password" {
  type        = string
  description = "Please provide the ID of the ContainerRegistry Connector Credentials - Password"
  default     = null
}

variable "azure_environment_type" {
  type        = string
  description = "ENV TYPE: AZURE or AZURE_US_GOVERNMENT"
  default     = "AZURE"

  validation {
    condition = (
      contains(["AZURE", "AZURE_US_GOVERNMENT"], var.azure_environment_type)
    )
    error_message = <<EOF
        Validation of Azure Environment Type Failed.
            * Must be one of the following:
            - AZURE
            - AZURE_US_GOVERNMENT
        EOF
  }
}

variable "user_assigned_client_id" {
  type        = string
  description = "Client ID for User Assigned Managed Identity"
  default     = null
}

variable "delegate_selectors" {
  type        = list(string)
  description = "List of delegate selectors to use for the connector"
  default     = ["build-farm"]
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}

variable "support_self_hosted" {
  type        = bool
  description = "Should Self-Hosted Build Infrastructures connectors be added?"
  default     = true
}

variable "support_harness_cloud" {
  type        = bool
  description = "Should Harness Cloud Build Infrastructures connectors be added?"
  default     = false
}
