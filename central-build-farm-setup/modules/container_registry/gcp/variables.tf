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

variable "delegate_selectors" {
  type        = list(string)
  description = "Delegate selectors"
  default     = ["build-farm"]
}

variable "container_registry_password" {
  type        = string
  description = "Please provide the ID of the ContainerRegistry Connector Credentials - Password"
  default     = null
}

variable "authentication_type_self_hosted" {
  type        = string
  description = "[Optional] Choose the authentication type for the connectors"
  default     = "manual"
}

variable "authentication_type_harness_cloud" {
  type        = string
  description = "[Optional] Choose the authentication type for the connectors"
  default     = "manual"
}

variable "oidc_workload_pool_id" {
  type        = string
  description = "Workload Pool ID for OIDC authentication"
  default     = null
}

variable "oidc_provider_id" {
  type        = string
  description = "Provider ID for OIDC authentication"
  default     = null
}

variable "oidc_project_id" {
  type        = string
  description = "GCP Project ID for OIDC authentication"
  default     = null
}

variable "oidc_service_account_email" {
  type        = string
  description = "Service Account Email for OIDC authentication"
  default     = null
}