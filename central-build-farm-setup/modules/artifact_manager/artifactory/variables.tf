variable "artifact_manager_username" {
  type        = string
  description = "Please provide the ID of the ArtifactManager Connector Credentials - Username"
}

variable "artifact_manager_password" {
  type        = string
  description = "Please provide the ID of the ArtifactManager Connector Credentials - Password"
}

variable "artifact_manager_url" {
  type        = string
  description = "Please provide the default URL for the Connector - e.g. https://artifactory.url"
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
