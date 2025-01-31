variable "container_registry_url" {
  description = "URL of the Helm server"
  type        = string
}

variable "auth_type" {
  type        = string
  description = "Authentication type: 'UsernamePassword' or 'Anonymous'"
}

variable "container_registry_username" {
  description = "Username for authentication (required if auth_type is username_password)"
  type        = string
}

variable "container_registry_password" {
  description = "Password reference for authentication (required if auth_type is username_password)"
  type        = string
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

variable "delegate_selectors" {
  description = "Delegate selectors"
  type        = list(string)
  default     = ["build-farm"]
}