variable "scm_username" {
  type        = string
  description = "Please provide the ID of the SCM Connector Credentials - Username"
}

variable "scm_password" {
  type        = string
  description = "Please provide the ID of the SCM Connector Credentials - Password"
}

variable "source_code_manager_url" {
  type        = string
  description = "Please provide the default URL for the Connector - e.g. https://bitbucket.com"
}

variable "source_code_manager_validation_repo" {
  type        = string
  description = "Please provide the validation URL for the Connector - e.g. harness/terraform-provider-harness"
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
