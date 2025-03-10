variable "container_registry_url" {
  type        = string
  description = "Rancher cluster URL for the Kubernetes connector"
}

variable "container_registry_password" {
  type        = string
  description = "Reference to the secret storing the Rancher bearer token"
}

variable "delegate_selectors" {
  description = "Delegate selectors"
  type        = list(string)
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
