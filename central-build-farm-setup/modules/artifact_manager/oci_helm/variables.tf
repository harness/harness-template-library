variable "artifact_manager_url" {
  type        = string
  description = "URL of the OCI Helm server"
}

variable "artifact_manager_auth_type" {
  type        = string
  description = "Authentication type: 'UsernamePassword' or 'Anonymous'"
}

variable "artifact_manager_username" {
  type        = string
  description = "Please provide the ID of the Connector Credentials - Username"
}

variable "artifact_manager_password" {
  type        = string
  description = "Please provide the ID of the Connector Credentials - Password"
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

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}

variable "artifact_manager_delegate" {
  description = "Delegate selectors"
  type        = list(string)
  default     = ["build-farm"]
}