variable "artifact_manager_url" {
  type        = string
  description = "Nexus server URL"
}

variable "nexus_version" {
  type        = string
  description = "Nexus server version"
}

variable "artifact_manager_auth_type" {
  type        = string
  description = "Authentication type: 'UsernamePassword' or 'Anonymous'"
}

variable "artifact_manager_username" {
  type        = string
  description = "[Optional] Username for Nexus authentication"
}

variable "artifact_manager_password" {
  type        = string
  description = "[Optional] Reference to the secret storing the Nexus password"
}

variable "support_self_hosted" {
  type        = bool
  description = "Should Self-Hosted Build Infrastructures connectors be added?"
  default     = true
}

variable "artifact_manager_delegate" {
  type        = list(string)
  description = "List of delegate selectors to use for the connector"
  default     = ["build-farm"]
}

variable "tags" {
  type        = map(any)
  description = "[Optional] Provide a Map of Tags to associate with the resources"
  default     = {}
}
