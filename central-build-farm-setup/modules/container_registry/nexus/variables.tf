variable "container_registry_url" {
  type        = string
  description = "Nexus server URL"
}

variable "nexus_version" {
  type        = string
  description = "Nexus server version"
}

variable "authentication_type_self_hosted" {
  type        = string
  description = "Authentication type for Nexus connector: UsernamePassword or Anonymous"
}

variable "container_registry_username" {
  type        = string
  description = "[Optional] Username for Nexus authentication"
}

variable "container_registry_password" {
  type        = string
  description = "[Optional] Reference to the secret storing the Nexus password"
}

variable "support_self_hosted" {
  type        = bool
  description = "Should Self-Hosted Build Infrastructures connectors be added?"
  default     = true
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
