# Variables
variable "authentication_type_self_hosted" {
  type        = string
  description = "Authentication method for self-hosted builds. Options: Secret, Certificate, ManagedIdentity"
}

variable "authentication_type_harness_cloud" {
  type        = string
  description = "Authentication method for cloud builds. Options: Secret, Certificate"
}

variable "identity_type" {
  type        = string
  description = "Identity type for InheritFromDelegate: UserAssignedManagedIdentity or SystemAssignedManagedIdentity"
}

variable "application_id" {
  type        = string
  description = "Azure application ID for authentication"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID for authentication"
}

variable "manual_credential_ref" {
  type        = string
  description = "Secret OR Certificate reference for Azure"
}

variable "azure_environment_type" {
  type        = string
  description = "ENV TYPE: AZURE or AZURE_US_GOVERNMENT"
  default     = "AZURE"
}

variable "user_assigned_client_id" {
  type        = string
  description = "Client ID for User Assigned Managed Identity"
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